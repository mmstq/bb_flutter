import 'package:cloud_firestore/cloud_firestore.dart';

class Data{
  static Stream<QuerySnapshot> querySnapshot = Firestore.instance.collection('ads').snapshots();
  static Stream<QuerySnapshot> query = Firestore.instance.collection('ads').where('price',isEqualTo: 'Free').snapshots();
  static bool isSort = false;
}