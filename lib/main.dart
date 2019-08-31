import 'package:bookbuddy/UI/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI/loginUI.dart';
import 'Utils/data.dart';

void main() async {
  sharedPreference = await SharedPreferences.getInstance();
  user = await FirebaseAuth.instance.currentUser();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'Login':(context)=> LoginPage(),
        'Buy':(context)=> LoginPage(),
        'Sell':(context)=> LoginPage(),
        'Main':(context)=> LoginPage(),
        'Detail':(context)=> LoginPage(),
      },
      title: 'Flutter Demo',
      theme: getTheme(isDark),
      home: (user == null)
          ? MainScreen()
          : LoginPage(),
    );
  }

  ThemeData getTheme(bool isDark) {
    if (isDark) {
      return ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF0c141f),
        primaryColorDark: Color(0xFF090f17),
        primaryColorLight: Color(0xFF141e2b),
        scaffoldBackgroundColor: Color(0xFF141e2b),
        accentColor: Colors.blue,
        dialogBackgroundColor: Color(0xFF1c2b3d),
        primarySwatch: Colors.blue,
        cardColor: Color(0xFF1c2b3d),
      );
    }
    return ThemeData(
        brightness: Brightness.light, scaffoldBackgroundColor: Colors.white);
  }
}
