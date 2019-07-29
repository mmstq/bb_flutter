import 'package:bookbuddy/Utils/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailedScreen extends StatelessWidget {
  final _docs;

  DetailedScreen(this._docs);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          GestureDetector(
            child: Hero(
                tag: "main${_docs['time']}",
                child: FadeInImage.assetNetwork(
                    height: 300,
                    width: screen.width,
                    fit: BoxFit.fill,
                    placeholder: _docs['thumbnail'],
                    image: _docs['image'])),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Container(
            height: 1,
            width: screen.width,
            color: Colors.deepOrange,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey,
                      fontFamily: fFamily,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 0.2,
                  width: screen.width * 0.8,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  _docs['book'] ?? 'null',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: fFamily,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  _docs['description'],
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                      fontFamily: fFamily,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 6,
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
                        text: _getTime(_docs['time']),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(1),
                  child: Text(
                    "  ${_docs['price']}  ",
                    style: TextStyle(
                        color: Colors.white,
                        backgroundColor: (_docs['price'] == 'Free')
                            ? Colors.green
                            : Colors.deepOrange,
//                        fontFamily: fFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/call.png',
                      width: 25,
                      height: 23,
                    ),
                    Text("  ${_docs['phone']}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: fFamily))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.deepOrangeAccent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.arrow_back),
                          Text(
                            "  Back",
                            style: TextStyle(fontFamily: fFamily),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.lightGreenAccent,
                      onPressed: () async {
                        final tel = "tel:${_docs['phone']}";
                        if (await canLaunch(tel)) {
                          await launch(tel);
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Not a valid number"),
                          ));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.call),
                          Text(
                            "  Call",
                            style: TextStyle(fontFamily: fFamily),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
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

var _stream = _getSort(Category.All);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[_getMenu()],
        title: Text("BookBuddy"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:  _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final _width = MediaQuery.of(context).size.width;
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data.documents.map((docs) {
              if (!docs["isDeleted"]) {
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
                                constraints:
                                    new BoxConstraints(maxWidth: _width * 0.20),
                                child: Column(
                                  children: <Widget>[
                                    Hero(
                                      tag: "main${docs['time']}",
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            docs['thumbnail'],
                                            height: 60,
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(1),
                                        child: Text(
                                          " ${docs['price']} ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              backgroundColor:
                                                  (docs['price'] == 'Free')
                                                      ? Colors.green
                                                      : Colors.deepOrange),
                                        ),
                                      ),
                                    ),
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
                                  constraints: new BoxConstraints(
                                      maxWidth: _width * 0.70),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          docs['description'],
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontFamily: fFamily,
                                              height: 0.9,
                                              fontWeight: FontWeight.w300),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      new Text(
                                        " ${_getTime(docs['time'])}",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontFamily: fFamily,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                );
              } else{
                return SizedBox(width: 0,height: 0,);
              }
            }).toList());
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          }
        },
      ),
    );
  }

  PopupMenuButton<Category> _getMenu() {
    final style = TextStyle(fontFamily: fFamily, color: Colors.white70);

    return PopupMenuButton<Category>(
      icon: Icon(Icons.sort),
      onSelected: (Category result) {
        _stream = _getSort(result);
        setState(() {

        });
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
  }
  else if (category == Category.BTech) {
    query = collectionReference.where("category", isEqualTo: "B.Tech");
  }
  else if (category == Category.MTech) {
    query = collectionReference.where("category", isEqualTo: "M.Tech");
  }
  else if (category == Category.Law) {
    query = collectionReference.where("category", isEqualTo: "Law");
  }
  else if (category == Category.PhD) {
    query = collectionReference.where("category", isEqualTo: "PhD");
  }
  else if (category == Category.Other) {
    query = collectionReference.where("category", isEqualTo: "Other");
  }
  else if (category == Category.Free) {
    query = collectionReference.where("price", isEqualTo: "Free");
  } else {
    query = collectionReference;
  }
  return query.snapshots();
}

String _getTime(int time) {
  final f = new DateFormat('E, dd-MM-yy hh:mm a');
  return f.format(new DateTime.fromMillisecondsSinceEpoch(time));
}
