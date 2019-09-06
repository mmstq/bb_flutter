import 'package:bookbuddy/Utils/data.dart';
import 'package:bookbuddy/Utils/data.dart' as prefix0;
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final boldStyle =
      TextStyle(fontFamily: fFamily, fontSize: 18, fontWeight: FontWeight.bold);
  final normalStyle = TextStyle(fontFamily: fFamily, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          "About",
          style: TextStyle(fontFamily: fFamily),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/me.png',
                height: prefix0.width * .45,
                width: prefix0.width * .45,
              ),
              SizedBox(
                width: prefix0.width * 0.01,
              ),
              Container(
                height: prefix0.width * .50,
                width: prefix0.width * .50,
                child: Center(
                  child: Text(
                    "BookBuddy Is A University Exclusive App To Buy,"
                    " Sell Or Donate Used Books Within MDU Campus.",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    softWrap: false,
                    style: TextStyle(fontFamily: fFamily, fontSize: 19),
                  ),
                ),
              ),
              SizedBox(
                width: prefix0.width * 0.03,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 10, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Version:",
                  style: boldStyle,
                ),
                Text(
                  "v1.2 (Beta)",
                  style: normalStyle,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Dev:",
                  style: boldStyle,
                ),
                Text(
                  "Mohd Mustak",
                  style: normalStyle,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Idea:",
                  style: boldStyle,
                ),
                Text(
                  "Piyush Aggarwal\n(Dropped Out)",
                  style: normalStyle,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Contact:",
                  style: boldStyle,
                ),
                Text(
                  "7011152375\nmushtakkhan9@gmail.com",
                  style: normalStyle,
                ),
              ],
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Image.asset(
                'assets/fb.png',
                height: height * 0.07,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  'assets/tree.png',
                  height: height * 0.12,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
