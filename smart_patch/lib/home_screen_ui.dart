import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'getPromo.dart';
import 'home_screen.dart';
import 'feeds_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenUI extends StatelessWidget {
  final FirebaseFirestore databaseReference = FirebaseFirestore.instance;
  FirebaseAuth auth;

  HomeScreenUI(this.auth);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Builder(
      builder: (context) => ListView(children: <Widget>[
        Card(
            elevation: 8,
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: Container(
              child: GetPromo(),
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20.0,
                    ),
                  ],
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(100.0))),
              padding:
                  EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 30),
            )),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Feeds',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Card(
                      elevation: 8,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: HomeScreen(auth))
                ],
              ),

              Column(children: <Widget>[
                Text(
                  'Connect',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Card(
                    elevation: 8,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: FeedsScreen())
              ])
              //Column(children: <Widget>[])
            ])
      ]),
    ));
  }
}
