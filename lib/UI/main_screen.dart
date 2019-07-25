import 'package:bookbuddy/UI/logout_dialog.dart';
import 'package:bookbuddy/UI/sell.dart';
import 'package:flutter/material.dart';

import 'detailscreen.dart';

class MainScreen extends StatelessWidget {
  final fFamily = "TitilliumWeb";

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    Scaffold.hasDrawer(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("BookBuddy"),
        ),
        drawer: new Drawer(
          child: Container(
            color: Color(0xFF1c2b3d),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: screen.height * .28,
                  child: new DrawerHeader(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0),
                    child: new Image.asset(
                      'assets/header.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                new ListTile(
                  leading: Image.asset('assets/home.png',width: 30,),
                  title: new Text('Home',style: TextStyle(color: Colors.white),),
                  onTap: () {
                    onMenuClick(0, context);
                  },
                ),
                new Divider(),
                new ListTile(
                  leading: Image.asset('assets/share.png',width: 30,),
                  title: new Text('Home',style: TextStyle(color: Colors.white),),
                  onTap: () {},
                ),
                new Divider(),
                new ListTile(
                  leading: Image.asset('assets/click.png',width: 30,),
                  title: new Text('Home',style: TextStyle(color: Colors.white),),
                  onTap: () {},
                ),
                new Divider(),
                new ListTile(
                  leading: Image.asset('assets/about.png',width: 30,),
                  title: new Text('Home',style: TextStyle(color: Colors.white),),
                  onTap: () {},
                ),
                new Divider(),
                new ListTile(
                  leading: Image.asset('assets/donate.png',width: 30,),
                  title: new Text('Home',style: TextStyle(color: Colors.white),),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
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
                height: screen.height * 0.25,
              ),
              Container(
                height: 1,
                width: screen.width * 0.81,
                color: Colors.grey,
              ),
              Spacer(
                flex: 2,
              ),
              Image.asset(
                'assets/bbtext.png',
                height: screen.height * 0.07,
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
                        height: screen.height * 0.18,
                        width: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/sell.png',
                              height: screen.height * 0.14,
                              width: screen.width * 0.22,
                              scale: .7,
                              color: Color(0xFF141e2b),
                            ),
                            Container(
                              height: screen.height * 0.04,
                              color: Colors.black26,
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
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return new ListScreen();
                        }));
                      },
                      padding: EdgeInsets.all(0),
                      child: Container(
                        height: screen.height * .12,
                        width: 90,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Spacer(),
                            Image.asset(
                              'assets/buy.png',
                              height: screen.height * 0.085,
                              scale: 0.6,
                              width: 80,
                              color: Color(0xFF141e2b),
                            ),
                            Spacer(),
                            Container(
                              height: screen.height * 0.03,
                              color: Colors.black26,
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
                      onPressed: () {},
                      padding: EdgeInsets.all(0),
                      child: Container(
                        height: screen.height * 0.12,
                        width: 90,
                        child: Column(
                          children: <Widget>[
                            Spacer(),
                            Image.asset(
                              'assets/list.png',
                              height: screen.height * 0.080,
                              color: Color(0xFF141e2b),
                            ),
                            Spacer(),
                            Container(
                              height: screen.height * 0.03,
                              color: Colors.black26,
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
                        height: screen.height * 0.15,
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/sign_out.png',
                              height: screen.height * 0.12,
                              width: screen.width * 0.23,
                              scale: .7,
                              color: Color(0xFF141e2b),
                            ),
                            Container(
                              height: screen.height * 0.03,
                              color: Colors.black26,
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
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ));
  }
  void onMenuClick(int id, BuildContext context){
//    Navigator.push(context, MaterialPageRoute(builder: (_));
    Route route = MaterialPageRoute(builder: (_)=> new MainScreen());
    debugPrint(route.isCurrent.toString());

  }
}