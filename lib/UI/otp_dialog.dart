import 'dart:async';

import 'package:bookbuddy/UI/main_screen.dart';
import 'package:bookbuddy/Utils/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpDialog extends StatefulWidget {
  @override
  _OtpDialogState createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  final _countController = StreamController();

  Stream get _counting => _countController.stream;
  final TextEditingController _otpController = new TextEditingController();
  Timer _timer;

  final TextStyle _textStyle = TextStyle(
      color: Colors.white70,
      fontFamily: fFamily,
      fontWeight: FontWeight.w300,
      fontSize: 15);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _countController.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 10),
      title: Row(
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(25),
            elevation: 5,
            child: CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.deepOrangeAccent,
                size: 35,
              ),
              radius: 23,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text("Verify OTP",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "TitilliumWeb",
                  fontWeight: FontWeight.w600,
                  fontSize: 20)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: fFamily,
                  fontWeight: FontWeight.w400),
              maxLength: 6,
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _otpController.text = "";
                    }),
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.person,
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 1,
                      color: Colors.white70,
                      height: 30,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                helperText: "Enter OTP",
                hintText: "_ _ _ _ _ _",
                labelStyle: TextStyle(color: Colors.white),
                labelText: "OTP",
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.lightBlueAccent),
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: _counting,
            initialData: 5,
            builder: (context, snapshot) {
              if (snapshot.data != 0) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Detecting OTP. Wait ", style: _textStyle),
                          TextSpan(
                            text: snapshot.data.toString(),
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontFamily: fFamily,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                          TextSpan(text: " sec ", style: _textStyle)
                        ],
                      ),
                    ),
                    Container(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                      ),
                    ),
                  ],
                );
              }else if(snapshot.data == 10){
                return Text("Wrong OTP Entered", style: TextStyle(fontSize: 15, fontFamily: fFamily,color: Colors.red));
              }
              return Text(
                "Enter OTP manually",
                style: TextStyle(fontSize: 15, fontFamily: fFamily),
              );
            },
          ),
        ],
      ),
      elevation: 35,
      backgroundColor: Colors.blueGrey.shade600,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      actions: [
        RaisedButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.red.shade900,
                  style: BorderStyle.solid,
                  width: 1),
              borderRadius: BorderRadius.circular(8)),
          elevation: 5,
          color: Colors.red,
          child: Text(
            " Re-Send ",
            style: TextStyle(
                color: Colors.red.shade900,
                fontFamily: "TitilliumWeb",
                fontWeight: FontWeight.w400,
                fontSize: 18),
          ),
          onPressed: () {
            _countController.close();
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.green.shade600,
                  style: BorderStyle.solid,
                  width: 1),
              borderRadius: BorderRadius.circular(8)),
          elevation: 5,
          color: Color(0xE276FF03),
          child: Text(
            " Done ",
            style: TextStyle(
                color: Colors.green.shade600,
                fontFamily: "TitilliumWeb",
                fontWeight: FontWeight.w400,
                fontSize: 18),
          ),
          onPressed: () {
            signInWithPhoneNumber(_otpController.text, context);
          },
        )
      ],
    );
  }

  void startTimer() {
    int count = 5;
    _timer = Timer.periodic(Duration(seconds: 1), (value) {
      if (count < 1) {
        _timer.cancel();
        _countController.add(0);
        _countController.close();
      } else {
        print("else: $count");
        count -= 1;
        _countController.add(count);
      }
    });
  }

  void signInWithPhoneNumber(String smsCode, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    await _auth
        .signInWithCredential(credential)
        .then((FirebaseUser user) async {
      final FirebaseUser _user = await _auth.currentUser();
      if (user.uid == _user.uid) {
//        Navigator.of(context).pop();
        print('success');
//        Navigator.of(context).pushNamedAndRemoveUntil('Main', (Route<dynamic> route)=> false);
      } else {
        print('failed');
        _countController.add(10);
        _countController.close();
      }
    });
  }
}
