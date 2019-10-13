import 'package:bookbuddy/UI/detailscreen.dart';
import 'package:bookbuddy/Utils/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyAds extends StatelessWidget {

  final _stream = Firestore.instance
      .collection('ads')
      .where('phone', isEqualTo: phone)
      .orderBy('time', descending: true)
      .snapshots();

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Your Ads',style: TextStyle(fontFamily: fFamily),),
      ),
      body: ListBuilder(_stream, true, _key),
    );
  }

}
