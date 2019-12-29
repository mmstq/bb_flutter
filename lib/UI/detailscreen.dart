import 'package:bookbuddy/Utils/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

Widget getImage(var docs) {
  final String image = docs['image'];
  if (image == null) {
    return Image.asset(
      'assets/no_image.png',
      height: height * 0.47,
      width: width,
      fit: BoxFit.cover,
    );
  }
  return FadeInImage.assetNetwork(
      height: height * 0.47,
      width: width,
      fit: BoxFit.fill,
      placeholder: docs['thumbnail'],
      image: docs['image']);
}

class DetailedScreen extends StatelessWidget {
  final _docs;

  DetailedScreen(this._docs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          child: Icon(Icons.call),
          tooltip: "Make Call",
          backgroundColor: Colors.lightGreenAccent.shade700,
          heroTag: "floatingActionButton",
          onPressed: () async {
            final tel = "tel:${_docs['phone']}";
            if (await canLaunch(tel)) {
              await launch(tel);
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Not a valid number"),
                  duration: Duration(milliseconds: 1000),
                ),
              );
            }
          },
        );
      }),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Hero(tag: "main${_docs['time']}", child: getImage(_docs)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
              height: 1,
              width: width,
              color: Colors.deepOrange,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Column(
              children: <Widget>[
                Text(
                  "Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: height * 0.033,
                      color: Colors.white70,
                      fontFamily: fFamily,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  height: 0.2,
                  width: width * 0.85,
                  color: Colors.white,
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    _docs['book'] ?? 'null',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: fFamily,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    _docs['description'],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 18,
                        fontFamily: fFamily,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Address : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: fFamily,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: _docs['address'],
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white70,
                            fontFamily: fFamily))
                  ]),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Posted On : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: fFamily,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: getTime(_docs['time']),
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white70,
                            fontFamily: fFamily))
                  ]),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "For : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: fFamily,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: _docs['category'],
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white70,
                            fontFamily: fFamily)),
                    TextSpan(
                        text: "   Sem : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: fFamily,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: _docs['semester'],
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white70,
                            fontFamily: fFamily))
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: (_docs['price'] == 'Free')
                          ? Colors.green
                          : Colors.deepOrange,
                      shape: BoxShape.rectangle),
                  child: Text(
                    "  ${_docs['price']}  ",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: fFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/call.png',
                      width: 25,
                      height: 20,
                    ),
                    Text(
                      "  ${_docs['phone']}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: fFamily),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum Category { All, BTech, MTech, Law, PhD, Medical, Other, Free }

class Buy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuyState();
  }
}

class _BuyState extends State<Buy> {
  Stream _stream = _getSort(Category.All);

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[_getMenu()],
        title: Text("BookBuddy"),
      ),
      body: ListBuilder(_stream, false, _key),
    );
  }

  PopupMenuButton<Category> _getMenu() {
    final style = TextStyle(fontFamily: fFamily, color: Colors.white70);

    return PopupMenuButton<Category>(
      icon: Icon(Icons.sort),
      onSelected: (Category result) {
        _stream = _getSort(result);
        setState(() {});
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Category>>[
        PopupMenuItem<Category>(
          value: Category.All,
          child: Text(
            'All',
            style: style,
          ),
        ),
        PopupMenuItem<Category>(
          value: Category.BTech,
          child: Text(
            'B.Tech',
            style: style,
          ),
        ),
        PopupMenuItem<Category>(
          value: Category.MTech,
          child: Text(
            'MTech',
            style: style,
          ),
        ),
        PopupMenuItem<Category>(
          value: Category.Medical,
          child: Text('Medical', style: style),
        ),
        PopupMenuItem<Category>(
          value: Category.PhD,
          child: Text('PhD', style: style),
        ),
        PopupMenuItem<Category>(
          value: Category.Law,
          child: Text('Law', style: style),
        ),
        PopupMenuItem<Category>(
          value: Category.Other,
          child: Text('Other', style: style),
        ),
        PopupMenuItem<Category>(
          value: Category.Free,
          child: Text('Free', style: style),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Stream<QuerySnapshot> _getSort(Category category) {
  CollectionReference collectionReference =
      Firestore.instance.collection('ads');
  var query;

  if (category == Category.Medical) {
    query = collectionReference.where("category", isEqualTo: "Medical");
  } else if (category == Category.BTech) {
    query = collectionReference.where("category", isEqualTo: "B.Tech");
  } else if (category == Category.MTech) {
    query = collectionReference.where("category", isEqualTo: "M.Tech");
  } else if (category == Category.Law) {
    query = collectionReference.where("category", isEqualTo: "Law");
  } else if (category == Category.PhD) {
    query = collectionReference.where("category", isEqualTo: "PhD");
  } else if (category == Category.Other) {
    query = collectionReference.where("category", isEqualTo: "Other");
  } else if (category == Category.Free) {
    query = collectionReference.where("price", isEqualTo: "Free");
  } else {
    query = collectionReference;
  }

  return query.orderBy('time', descending: true).snapshots();
}

String getTime(int time) {
  final f = new DateFormat('E, dd-MM-yy hh:mm a');
  return f.format(new DateTime.fromMillisecondsSinceEpoch(time));
}

class ListBuilder extends StatefulWidget {
  final _stream;
  final _isMyAds;
  final _scaffoldKey;
  var _uniqueKey;

  ListBuilder(this._stream, this._isMyAds, this._scaffoldKey);

  @override
  _ListBuilderState createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  final TextStyle _textStyle =
      TextStyle(fontFamily: fFamily, fontWeight: FontWeight.w400, fontSize: 17);
  var _animated = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget._stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        final _width = MediaQuery.of(context).size.width;
        if (snapshot.hasData) {
          return ListView(
              children: snapshot.data.documents.map((docs) {
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: Card(
                  elevation: 8,
                  child: Container(
                    height: 110,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: 60,
                            constraints:
                                new BoxConstraints(maxWidth: _width * 0.20),
                            child: Column(
                              children: <Widget>[
                                Hero(
                                  tag: "main${docs['time']}",
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: docs['thumbnail'] != null
                                          ? Image.network(
                                              docs['thumbnail'],
                                              height: 60,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.asset(
                                              'assets/no_image.png',
                                              height: 60,
                                              fit: BoxFit.fill,
                                            )),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                _priceOrDelete(docs),
                              ],
                              mainAxisSize: MainAxisSize.min,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          new DetailedScreen(docs)));
                            },
                            child: Container(
                              constraints:
                                  new BoxConstraints(maxWidth: _width * 0.70),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    docs['book'] ?? 'null',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontFamily: fFamily,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0, top: 2),
                                    child: Text(
                                      docs['description'],
                                      style: TextStyle(
                                          color: Colors.white54,
                                          fontFamily: fFamily,
                                          height: 1.2,
                                          fontWeight: FontWeight.w300),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  new Text(
                                    " ${getTime(docs['time'])}",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontFamily: fFamily,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                                mainAxisSize: MainAxisSize.min,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            );
          }).toList());
        } else {
          return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          ));
        }
      },
    );
  }

  Future<bool> deleteAd(var docs) async {
    final reference = Firestore.instance;
    bool _successful;
    DocumentReference dr =
        reference.collection('ads').document(docs['time'].toString());
    await Future.delayed(Duration(milliseconds: 1000));
    await dr.delete().catchError((error) {
      debugPrint("error");
      _successful = false;
      _showUploadingSnackBar("Failed. Re-Try", Icon(Icons.error_outline, color: Colors.white));


    }).whenComplete(() {
      debugPrint("success");
      _successful = true;
      _showUploadingSnackBar("Ad Deleted Successfully", Icon(Icons.check_circle_outline, color: Colors.white));

    });
    return _successful;

  }

  Widget _priceOrDelete(var docs) {
    if (widget._isMyAds) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(child: child, scale: animation);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: (_animated && widget._uniqueKey == docs['time'])
              ? Container(
                  key: ValueKey("first"),
                  padding: EdgeInsets.all(4),
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    strokeWidth: 1.5,
                  ),
                )
              : Container(
                  key: ValueKey("second"),
                  height: 25,
                  padding: EdgeInsets.fromLTRB(1, 0, 1, 1),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Text(" Delete ", style: TextStyle(color: Colors.red),
                        ),
                        onTap: () async {
                          widget._uniqueKey = docs['time'];
                          setState(() async {
                            _animated = !_animated;
                            /*final successful = await deleteAd(docs);

                              if (successful){
                                setState(() {

                                });
                              }*/
                            });
//                        _showUploadingSnackBar(Duration(minutes: 1));
                        },
                      ),
                    ],
                  ),
                ),
        ),
      );
    }
    return Center(
      key: ValueKey<String>(docs['time'].toString()),
      child: Container(
        padding: EdgeInsets.fromLTRB(1, 1, 1, 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: (docs['price'] == 'Free') ? Colors.green : Colors.deepOrange,
            shape: BoxShape.rectangle),
        child: Text(
          "  ${docs['price']}  ",
          style: TextStyle(
              color: Colors.white,
              fontFamily: fFamily,
              fontWeight: FontWeight.w600,
              fontSize: 12),
        ),
      ),
    );
  }

  _showUploadingSnackBar(String msg, Icon icon) {
    widget._scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 20,
              width: 20,
              child: icon
              ),
          SizedBox(
            width: 10,
          ),
          Text(
            msg,
            maxLines: 3,
            style: _textStyle,
          ),
        ],
      ),
      duration: Duration(milliseconds: 1500),
      backgroundColor: Colors.indigo,
    ));
  }
}
