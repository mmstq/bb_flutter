import 'package:flutter/material.dart';
import 'UI/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color(0xFF0c141f),
          primaryColorDark: Color(0xFF090f17),
          scaffoldBackgroundColor: Color(0xFF141e2b),
          cardColor: Color(0xFF1c2b3d)),
      home: MainScreen(),
    );
  }
}






