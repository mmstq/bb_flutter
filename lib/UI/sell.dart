import 'package:flutter/material.dart';

class Sell extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SellState();
  }
}

class SellState extends State<Sell> {
  final Map<String, dynamic> _map = new Map();
  final _key = GlobalKey();
  final _enableBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.white70),
  );
  final _focusBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.lightBlue),
  );
  final _roundCard = RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell or Donate'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(
                'Want to sell or donate book',
                textAlign: TextAlign.center,
              ),
              Text(
                'Fill out some details and you are good to go',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Builder(
                builder: (context) => Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: _roundCard,
                        elevation: 10,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Book Name',
                             enabledBorder: _enableBorder,
                            focusedBorder: _focusBorder,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: _roundCard,
                        elevation: 10,
                        child: TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Description',
                            enabledBorder: _enableBorder,
                            focusedBorder: _focusBorder,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
