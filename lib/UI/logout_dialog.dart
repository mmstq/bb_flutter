import 'dart:io';

import 'package:flutter/material.dart';


showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = Material(
      elevation: 5,
      color: Colors.blueGrey.shade600,
      borderRadius: BorderRadius.circular(5),
      child: IconButton(
        icon: Icon(Icons.check),
        color: Color(0xFF76FF03),
        onPressed: () {
          exit(0);
        },
      ),
    );
    Widget cancelButton = Material(
      elevation: 5,
      color: Colors.blueGrey.shade600,
      borderRadius: BorderRadius.circular(5),
      child: IconButton(
        icon: Icon(Icons.close),
        color: Colors.red,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(25),
            elevation: 5,
            child: CircleAvatar(child: Icon(Icons.person, color: Colors.deepOrangeAccent,size: 35,),
            radius: 23,
            backgroundColor: Colors.white,),
          ),
          SizedBox(
            width: 10,
          ),
          Text("Sign Out",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "TitilliumWeb",
                fontWeight: FontWeight.w600,
                fontSize: 20
              )),
        ],
      ),
      content: Text(
        "Do You Want To Sign Out..?",
        style: TextStyle(color: Colors.white,fontFamily: "TitilliumWeb",
                fontWeight: FontWeight.w400,fontSize: 18),
      ),
      elevation: 15,
      backgroundColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }