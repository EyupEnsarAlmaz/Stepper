import 'package:flutter/material.dart';

class Bilgiler extends StatefulWidget {
  String? name, email, sifre;
  int aktifolanstep;

  Bilgiler(
      {required this.name,
      required this.email,
      required this.sifre,
      required this.aktifolanstep});

  @override
  State<Bilgiler> createState() => _BilgilerState();
}

String sifre = "******";

class _BilgilerState extends State<Bilgiler> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text("Completed"),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Text('Username: ${widget.name}'),
                ),
                Container(
                  child: Text('Mail: ${widget.email}'),
                ),
                Container(
                  child: Text('Password: $sifre'),
                ),
                Container(
                  margin: EdgeInsets.all(100),
                  child: Image.asset("asset/completed.jpg"),
                  width: 150,
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "RESET",
                    style: TextStyle(fontSize: 20),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
          )),
    );
  }
}
