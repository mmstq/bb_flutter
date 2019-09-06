import 'package:bookbuddy/Utils/data.dart' as prefix0;
import 'package:flutter/material.dart';

class Donate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/donation.png',
              height: prefix0.height * .25,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "How Can I Support ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: prefix0.fFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "This app is completely free to use.You do not need to pay "
              "a single penny to use any feature of this app.\n"
              "However you can donate to the developer of this "
              "app so that he canfurther maintain and can add new features"
              " to the app.\nYou can donate any amount you can."
              "\nYou can pay only through PayTM with a message \'Gud Work\'"
                  " or with an improvement or suggestion or feature request."
                  "\nThank You :)",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: prefix0.fFamily,
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
