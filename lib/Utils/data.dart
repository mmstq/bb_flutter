
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

bool isDark = true;
bool isOTP = false;
FirebaseUser user;
String phone = "+917011152375";
final fFamily = "TitilliumWeb";
double height = 0;
bool isDialogDoneOneTime = false;
double width = 0;
var sharedPreference;
String verificationId;
final phoneHelperText = "Enter number w/o +91";
final loginDescription = "BookBuddy is an Unofficial MDU University exclusive app to buy, "
    "sell or donate used books within MDU Campus only.";

final countController = StreamController();
Stream get counting => countController.stream;


void close(){
  countController.close();
}
