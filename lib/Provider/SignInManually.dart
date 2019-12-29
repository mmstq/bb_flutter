import 'dart:async';

import 'package:bookbuddy/UI/main_screen.dart';
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
    FirebaseAuth _auth = FirebaseAuth.instance;
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await _auth.signInWithCredential(credential).whenComplete(() async {
      final FirebaseUser user = await _auth.currentUser();
      debugPrint('when completed uid is : ' + user.uid);
      Navigator.pop(context);
      Future.delayed(Duration(milliseconds: 300));
      Navigator.push(context, MaterialPageRoute(builder: (_)=>MainScreen()));
    });
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


