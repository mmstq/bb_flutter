import 'dart:async';

import 'package:bookbuddy/UI/otp_dialog.dart';
import 'package:bookbuddy/Utils/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    height = _screen.height;
    width = _screen.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              SizedBox(height: height * .075),
              new Text(
                'Welcome To BookBuddy',
                style: TextStyle(
                    fontFamily: fFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: height * .045),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              new Text(
                loginDescription,
                style: TextStyle(
                    fontFamily: fFamily,
                    fontWeight: FontWeight.w300,
                    fontSize: height * 0.025),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.red,
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.arrow_back),
                        Text(
                          "   Exit   ",
                          style: TextStyle(fontFamily: fFamily),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.transparent,
                    onPressed: () async {
                      final url = "https://github.com/mmstq/bb_flutter";
                      if (await canLaunch(url)) {
                        launch(url);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset(
                          'assets/github.png',
                          height: 18,
                        ),
                        Text(
                          "   GitHub",
                          style: TextStyle(fontFamily: fFamily),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),
              Container(
                height: 1,
                color: Colors.white70,
              ),
              SizedBox(height: height * 0.045),
              CircleAvatar(
                radius: height * 0.065,
                backgroundImage: AssetImage('assets/user.png'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: fFamily,
                      fontWeight: FontWeight.w400),
                  maxLength: 10,
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _phoneController.text = "";
                        }),
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.person,
                          size: 35,
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
                    helperText: phoneHelperText,
                    hintText: "+91",
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Phone Number',
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
              RaisedButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.blue.shade700,
                        width: 2,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.lightBlueAccent,
                onPressed: () {
                  String _phone = _phoneController.text;
                  phone = _phone;
                  sharedPreference.setString('phone', _phone);
                  _sendCodeToPhone(widget._auth, context, _phone);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.send),
                    Text(
                      "   Submit",
                      style: TextStyle(fontFamily: fFamily),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendCodeToPhone(
      FirebaseAuth auth, BuildContext context, String phoneRaw) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) {
      auth.signInWithCredential(credential).then((FirebaseUser user) async {
        final FirebaseUser _user = await auth.currentUser();
        if (user.uid == _user.uid) {
          isOTP = false;
          debugPrint("completed: " + user.uid);
        }
      });
    };

    final PhoneVerificationFailed phoneVerificationFailed =
        (AuthException authException) {
      print("PVF: ${authException.message}");
      countController.add(authException.message);
    };

    final PhoneCodeSent phoneCodeSent =
        (String verifyId, [int forceResendingToken]) {
      verificationId = verifyId;
      show();
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verifyId) {
      verificationId = verifyId;
      print("time out: ");
    };

    await auth.verifyPhoneNumber(
        phoneNumber: "+91" + phoneRaw,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void show() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return OtpDialog();
      },
    );
  }
}
