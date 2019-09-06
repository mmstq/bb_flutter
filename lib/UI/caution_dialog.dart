

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

showCautionDialog(BuildContext context) {
  // set up the button

  Widget cancelButton = RaisedButton(
    shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.orange.shade900, style: BorderStyle.solid, width: 1),
        borderRadius: BorderRadius.circular(8)),
    elevation: 5,
    color: Colors.red,
    child: Icon(Icons.close,color: Colors.black26,),
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
            child: Padding(
              padding: const EdgeInsets.only(bottom:3.0),
              child: Icon(
                Icons.warning,
                color: Colors.deepOrangeAccent,
                size: 30,
              ),
            ),
            radius: 23,
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Text("Caution",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "TitilliumWeb",
                fontWeight: FontWeight.w600,
                fontSize: 20)),
      ],
    ),
    content: Text(
      "Keep following things in mind while buying or selling book on BookBuddy."
          "\n\n1. Look for library TAG. Never buy library book.\n"
          "2. Verify Book, Edition, Semester and Author before buy.\n"
          "3. Do not forget to delete your ads after selling book.",
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
    actions: [cancelButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}
