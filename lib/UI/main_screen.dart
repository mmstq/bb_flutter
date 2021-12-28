import 'package:bookbuddy/UI/drawer.dart';
import 'package:bookbuddy/UI/logout_dialog.dart';
import 'package:bookbuddy/UI/myads.dart';
import 'package:bookbuddy/UI/sell.dart';
import 'package:bookbuddy/Utils/data.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    height = _screen.height;
    width = _screen.width;
    Scaffold.hasDrawer(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("BookBuddy"),
      ),
      drawer: DrawerMenu(),
      // All Content In The Body Section
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(
              flex: 2,
            ),
            Image.asset(
              'assets/bookshelf.png',
              height: height * 0.25,
            ),
            Container(
              height: 1,
              width: width * 0.81,
              color: Colors.grey,
            ),
            Spacer(
              flex: 2,
            ),
            Image.asset(
              'assets/bbtext.png',
              height: height * 0.07,
            ),
            Spacer(
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Card(
                  color: Colors.deepOrange,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return new Sell();
                      }));
                    },
                    padding: EdgeInsets.all(0),
                    child: Container(
                      height: height * 0.18,
                      width: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/sell.png',
                            height: height * 0.14,
                            width: width * 0.22,
                            scale: .7,
                            color: Color(0xFF141e2b),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                )),
                            height: height * 0.04,
                            //                              color: Colors.black26,
                            child: Center(
                              child: Text("Sell or donate books",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      height: 0.7,
                                      color: Colors.white,
                                      fontFamily: fFamily,
                                      fontWeight: FontWeight.w400)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Color(0xFF49c423),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('Buy');
                    },
                    padding: EdgeInsets.all(0),
                    child: Container(
                      height: height * .12,
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Spacer(),
                          Image.asset(
                            'assets/buy.png',
                            height: height * 0.085,
                            scale: 0.6,
                            width: 80,
                            color: Color(0xFF141e2b),
                          ),
                          Spacer(),
                          Container(
                            height: height * 0.03,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                )),
                            child: Center(
                              child: Text("Buy books",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      height: 0.7,
                                      color: Colors.white,
                                      fontFamily: fFamily,
                                      fontWeight: FontWeight.w400)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  color: Colors.lightBlue,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return new MyAds();
                      }));
                    },
                    padding: EdgeInsets.all(0),
                    child: Container(
                      height: height * 0.12,
                      width: 90,
                      child: Column(
                        children: <Widget>[
                          Spacer(),
                          Image.asset(
                            'assets/list.png',
                            height: height * 0.080,
                            color: Color(0xFF141e2b),
                          ),
                          Spacer(),
                          Container(
                            height: height * 0.03,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                )),
                            child: Center(
                              child: Text("See your ads",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      height: 0.7,
                                      color: Colors.white,
                                      fontFamily: fFamily,
                                      fontWeight: FontWeight.w400)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.yellow,
                  child: MaterialButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    padding: EdgeInsets.all(0),
                    child: Container(
                      height: height * 0.15,
                      width: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/sign_out.png',
                            height: height * 0.12,
                            width: width * 0.23,
                            scale: .7,
                            color: Color(0xFF141e2b),
                          ),
                          Container(
                            height: height * 0.03,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                )),
                            child: Center(
                              child: Text("Sign out",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      height: 0.7,
                                      color: Colors.white,
                                      fontFamily: fFamily,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
