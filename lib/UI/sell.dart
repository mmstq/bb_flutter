import 'dart:io';

import 'package:bookbuddy/Utils/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Sell extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SellState();
}

class _SellState extends State<Sell> {
  final Map<String, dynamic> _map = new Map();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _enableBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6)),
    borderSide: BorderSide(color: Colors.white70),
  );
  final _focusBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6)),
    borderSide: BorderSide(color: Colors.lightBlue),
  );

  final _errorBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6)),
    borderSide: BorderSide(color: Colors.red),
  );

  TextStyle _textStyle =
      TextStyle(fontFamily: fFamily, fontWeight: FontWeight.w400, fontSize: 17);

  bool _isValidated = false;
  String _category;
  String _bookName;
  String _description;
  String _address;
  String _price;
  String _semester;
  String _photoUrl;
  String _thumbnailUrl;
  var _isFree = false;
  File _photo;
  File _thumbnail;

  bool _count = false;

  int _timeStamp;

  @override
  void initState() {
    super.initState();
    _timeStamp = _getCurrentTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sell or Donate',
          style: _textStyle,
        ),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.send,
              ),
              onPressed: () {
                _validateInputs(context);
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Want to sell or donate book',
                  style: TextStyle(
                      fontFamily: fFamily,
                      fontWeight: FontWeight.w300,
                      fontSize: 17,
                      color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Fill out some details and you are good to go',
                  style: TextStyle(
                      fontFamily: fFamily,
                      fontWeight: FontWeight.w300,
                      fontSize: 17,
                      color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Builder(
                  builder: (context) => Form(
                    key: _key,
                    autovalidate: _isValidated,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          style: _textStyle,
                          maxLength: 50,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.book),
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Book Name',
                            enabledBorder: _enableBorder,
                            focusedBorder: _focusBorder,
                            errorBorder: _errorBorder,
                            focusedErrorBorder: _focusBorder,
                          ),
                          validator: (String value) {
                            if (value == "") {
                              return "Enter Book Name";
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _bookName = value;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          style: _textStyle,
                          maxLines: 3,
                          maxLength: 180,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.description),
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Description',
                            helperText: "like edition, semester, author etc.",
                            enabledBorder: _enableBorder,
                            focusedBorder: _focusBorder,
                            focusedErrorBorder: _focusBorder,
                            errorBorder: _errorBorder,
                          ),
                          validator: (String value) {
                            print("des validate");
                            if (value == "") {
                              return "Enter Description";
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _description = value;
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          style: _textStyle,
                          maxLength: 5,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.bookmark),
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Semester',
                            enabledBorder: _enableBorder,
                            focusedBorder: _focusBorder,
                            focusedErrorBorder: _focusBorder,
                            errorBorder: _errorBorder,
                          ),
                          validator: (String value) {
                            if (value == "") {
                              return "Enter Semester";
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _semester = value;
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          style: _textStyle,
                          maxLength: 40,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.not_listed_location),
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Address',
                            hintText: "",
                            helperText: "like room & hostel number",
                            enabledBorder: _enableBorder,
                            focusedBorder: _focusBorder,
                            focusedErrorBorder: _focusBorder,
                            errorBorder: _errorBorder,
                          ),
                          validator: (String value) {
                            if (value == "") {
                              return "Enter Address";
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _address = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: new DropdownButton<String>(
                              underline: Container(),
                              hint: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.category),
                                  Text(
                                    (_category == null)
                                        ? "  Select Category"
                                        : "  :  " + _category,
                                    style: _textStyle,
                                  ),
                                ],
                              ),
                              isExpanded: true,
                              items: <String>[
                                'B.Tech',
                                'Law',
                                'M.Tech',
                                'Medical',
                                'PhD',
                                'Other'
                              ].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(
                                    value,
                                    style: _textStyle,
                                  ),
                                );
                              }).toList(),
                              onChanged: (item) {
                                print(item);
                                setState(() {
                                  _category = item;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                      child: child, scale: animation);
                                },
                                child: Image.asset(
                                  _count
                                      ? "assets/happy.png"
                                      : "assets/normal.png",
                                  height: 25,
                                  key: ValueKey<bool>(_count),
                                ),
                              ),
                              Checkbox(
                                value: _isFree,
                                onChanged: ((value) {
                                  setState(() {
                                    _isFree = !_isFree;
                                    _count = !_count;
                                  });
                                }),
                              ),
                              Text(
                                "Select if you want to donate",
                                style: TextStyle(
                                    fontFamily: fFamily,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: width * .5,
                              height: height * .09,
                              child: TextFormField(
                                maxLength: 13,
                                enabled: false,
                                style: TextStyle(
                                    fontFamily: fFamily,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone_android),
                                  disabledBorder: _enableBorder,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  labelText: phone,
                                  focusedBorder: _focusBorder,
                                  enabledBorder: _enableBorder,
                                  focusedErrorBorder: _focusBorder,
                                  errorBorder: _errorBorder,
                                ),
                              ),
                            ),
                            Container(
                              width: width * .35,
                              height: height * 0.09,
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: TextFormField(
                                  key: ValueKey<bool>(_count),
                                  onSaved: (String value) {
                                    _price = value;
                                  },
                                  validator: ((value) {
                                    if (value == "" && !_isFree) {
                                      return "Enter Price";
                                    }
                                    return null;
                                  }),
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontFamily: fFamily,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                  maxLength: 4,
                                  enabled: !_isFree,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.attach_money),
                                    disabledBorder: _enableBorder,
                                    labelStyle: TextStyle(color: Colors.white),
                                    labelText: _isFree ? 'Free' : 'Price',
                                    hintText: "₹",
                                    focusedBorder: _focusBorder,
                                    enabledBorder: _enableBorder,
                                    focusedErrorBorder: _focusBorder,
                                    errorBorder: _errorBorder,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: MaterialButton(
                            height: height * 0.07,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                              6,
                            )),
                            color:
                                (_photo != null) ? Colors.green : Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                (_photo != null)
                                    ? Text(
                                        "Select Image Again",
                                        style: _textStyle,
                                      )
                                    : Text(
                                        'Select Image',
                                        style: _textStyle,
                                      ),
                                (_photo != null)
                                    ? Icon(Icons.done)
                                    : Icon(Icons.camera_enhance)
                              ],
                            ),
                            onPressed: () {
                              _imagePickerOption();
                            },
                          ),
                        ),
                        _getImagePreview(_photo),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateInputs(BuildContext context) {
    print('validateInputs');
    print(_category);
    if (_key.currentState.validate()) {
      if (_category == null) {
        showSnackBar(context, "Select Category");
        return null;
      }
      _key.currentState.save();
      if (_photo == null) {
        _showNoImageDialog(context);
      } else {
        _sendToServer();
      }
    } else {
      setState(() {
        _isValidated = true;
      });
    }
  }

  void showSnackBar(BuildContext context, String msg) {
    print('showSnackbar');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: _textStyle,
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    ));
  }

  Widget _getImagePreview(File file) {
    print('getImagePreview');
    if (file != null)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "Image Preview",
            textAlign: TextAlign.center,
            style: _textStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Image.file(
            file,
            height: height * 0.47,
            fit: BoxFit.fill,
            width: width,
          ),
        ],
      );
    else
      return Container();
  }

  Future<void> _imagePickerOption() {
    print('imagePickerOption');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                MaterialButton(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.add_a_photo),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Take a picture',
                        style: _textStyle,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    _photo = await _openImagePicker(ImageSource.camera);
                    setState(() {});
                  },
                ),
                MaterialButton(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.add_photo_alternate),
                      SizedBox(
                        width: 10,
                      ),
                      new Text(
                        'Select from gallery',
                        style: _textStyle,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    _photo = await _openImagePicker(ImageSource.gallery);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<File> _openImagePicker(ImageSource source) async {
    print('_openImagePicker()');
    _photo = await ImagePicker.pickImage(
        source: source, imageQuality: 10, maxHeight: 800, maxWidth: 800);
    final Directory directory = await getTemporaryDirectory();
    final copyFile = await _photo.copy('${directory.path}/photo.png');
    _photo = await FlutterExifRotation.rotateImage(path: copyFile.path);
    final image = img.decodeImage(new File(copyFile.path).readAsBytesSync());
    _thumbnail = new File('${directory.path}/thumbnail.png')
      ..writeAsBytesSync(img.encodePng(img.copyResize(
        image,
        width: 50,
        height: 50,
      )));
    return _photo;

  }

  int _getCurrentTime() {
    print('getCurrentTime');
    _timeStamp = new DateTime.now().millisecondsSinceEpoch;
    return _timeStamp;
  }

  _showNoImageDialog(BuildContext context) {
    print('showNoImageDialog');
    Widget okButton = RaisedButton(
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.green.shade800, style: BorderStyle.solid, width: 1),
          borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      color: Colors.lightGreenAccent.shade700,
      child: Icon(
        Icons.check,
        color: Colors.green.shade800,
      ),
      onPressed: () {
        _sendToServer();
      },
    );
    Widget cancelButton = RaisedButton(
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.red.shade900, style: BorderStyle.solid, width: 1),
          borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      color: Colors.red,
      child: Icon(
        Icons.close,
        color: Colors.red.shade900,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    var alert = AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 10),
        title: Row(
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.circular(25),
              elevation: 5,
              child: CircleAvatar(
                child: Icon(
                  Icons.broken_image,
                  color: Colors.deepOrangeAccent,
                  size: 30,
                ),
                radius: 23,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "No Image",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "TitilliumWeb",
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        ),
        content:
            Text("No image selected.\nDo you want to proceed without image?"),
        elevation: 35,
        backgroundColor: Colors.blueGrey.shade600,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        actions: [cancelButton, okButton]);

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Future<String> _getUploadUrl(File file, bool isThumbnail) async {
    final reference = FirebaseStorage.instance.ref().child(isThumbnail
        ? '/adsImage/$_timeStamp-thumbnail.png'
        : '/adsImage/$_timeStamp.png');

    var uploadTask = reference.putFile(file);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return url.toString();
  }

  Future<void> _sendToServer() async {
    print('sendToServer');

    if (_photo != null) {
      _photoUrl = await _getUploadUrl(_photo, false);
      _thumbnailUrl = await _getUploadUrl(_thumbnail, true);
    }

    _map['book'] = _bookName;
    _map['description'] = _description;
    _map['address'] = _address;
    _map['price'] = _price;
    _map['category'] = _category;
    _map['isDeleted'] = false;
    _map['phone'] = phone;
    _map['time'] = _timeStamp;
    _map['thumbnail'] = _thumbnailUrl;
    _map['image'] = _photoUrl;
    _map['semester'] = _semester;

    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference collectionReference =
          Firestore.instance.collection('ads').document(_timeStamp.toString());
      await collectionReference.setData(_map).whenComplete((){

      });
    });

    print("photoUrl: $_photoUrl tUrl: $_thumbnailUrl");
  }
}
