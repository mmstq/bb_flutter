import 'package:bookbuddy/UI/detailscreen.dart';
import 'package:bookbuddy/UI/main_screen.dart';
import 'package:bookbuddy/UI/sell.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookbuddy/Utils/data.dart';
import 'package:bookbuddy/UI/loginUI.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'Login': (context) => LoginPage(),
        'Buy': (context) => Buy(),
        'Sell': (context) => Sell(),
        'Main': (context) => MainScreen(),
        'Splash': (context) => SplashScreen(),
      },
      title: 'BookBuddy',
      theme: getTheme(isDark),
      home: SplashScreen(),
      /*FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot){
          if(snapshot.connectionState == ConnectionState.done) {
            sharedPreference = snapshot.data;
            debugPrint("futurebuilder: ${snapshot.data.getString('uid')}");
            return (snapshot.data.getString('uid') != null) ? MainScreen() : LoginPage();
          }else{
            debugPrint("futurebuilder else: ${snapshot.data.getString('uid')}");
            return SplashScreen();
          }
        },
      ),*/
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

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initiate(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            'icon/icon.png',
            height: 120,
            width: 120,
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/bbtext.png',
            height: 50,
          ),
        ],
      ),
    );
  }

  Route _createRoute(Widget route) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => route,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.ease);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });
  }

  void initiate(BuildContext context) async {
    sharedPreference = await SharedPreferences.getInstance();
    userUID = sharedPreference.get('uid') ?? null;
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushAndRemoveUntil(
        (userUID == null)
            ?CustomPageBuilder(LoginPage())
            : CustomPageBuilder(MainScreen()),
        (Route<dynamic> route) => false);
  }
}

class CustomPageBuilder<T> extends PageRoute<T> {
  CustomPageBuilder(this.child);
  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => null;
  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(seconds: 1);

}
