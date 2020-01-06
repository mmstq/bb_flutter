
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isDark = true;
bool isOTP = false;
String userUID;
bool exitSplash = false;
String phone = "+917011152375";
final fFamily = "TitilliumWeb";
double height = 0;
bool isDialogDoneOneTime = false;
double width = 0;
SharedPreferences sharedPreference;
String verificationId;
final phoneHelperText = "Enter number w/o +91";
final loginDescription = "BookBuddy is an Unofficial MDU University exclusive app to buy, "
    "sell or donate used books within MDU Campus only.";




