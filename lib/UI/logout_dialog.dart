

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = RaisedButton(
    shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Colors.green.shade600 , style: BorderStyle.solid, width: 1),
        borderRadius: BorderRadius.circular(8)),
    elevation: 5,
    color: Color(0xE276FF03),
    child: Icon(Icons.check,color: Colors.green.shade600,),
    onPressed: () {
      FirebaseAuth.instance.signOut();
    },
  );
  Widget cancelButton = RaisedButton(
    shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.red.shade900, style: BorderStyle.solid, width: 1),
        borderRadius: BorderRadius.circular(8)),
    elevation: 5,
    color: Colors.red,
    child: Icon(Icons.close,color: Colors.red.shade900,),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(25),
          elevation: 5,
          child: CircleAvatar(
            child: Icon(
              Icons.person,
              color: Colors.deepOrangeAccent,
              size: 35,
            ),
            radius: 23,
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text("Sign Out",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "TitilliumWeb",
                fontWeight: FontWeight.w600,
                fontSize: 20)),
      ],
    ),
    content: Text(
      "Do You Want To Sign Out..?",
      style: TextStyle(
          color: Colors.white,
          fontFamily: "TitilliumWeb",
          fontWeight: FontWeight.w400,
          fontSize: 18),
    ),
    elevation: 35,
    backgroundColor: Colors.blueGrey.shade600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    actions: [cancelButton, okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}
