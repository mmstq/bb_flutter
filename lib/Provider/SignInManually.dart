import 'dart:async';
import 'package:bookbuddy/Utils/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPSubmit extends ChangeNotifier {

  int _count = 5;
  Timer _timer;

  OTPSubmit(){
    startTimer();
  }

  int getCounter() => _count;

  void signInWithPhoneNumber(String smsCode, BuildContext context) async {
    // FirebaseAuth _auth = FirebaseAuth.instance;
    // final AuthCredential credential = PhoneAuthProvider.getCredential(
    //   verificationId: verificationId,
    //   smsCode: smsCode,
    // );
    // final uid =
    //     (await _auth.signInWithCredential(credential)).uid;
    // final FirebaseUser currentUser = await _auth.currentUser();
    // assert(uid == currentUser.uid);
    //   if (uid != null) {
    //     debugPrint('when completed uid is : ' + uid);
    //     Navigator.pop(context);
    //     Future.delayed(Duration(milliseconds: 300));
    //     Navigator.of(context).pushNamedAndRemoveUntil('Main', (Route<dynamic> route)=>false);
    //     sharedPreference.setString('uid', uid);
    //   } else {
    //     debugPrint('Authentication failde');
    //   }

  }
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (value) {
      if (_count < 1) {
        _timer.cancel();
        notifyListeners();
      } else {
        print("else: $_count");
        _count -= 1;
        notifyListeners();
      }
    });
  }

}


