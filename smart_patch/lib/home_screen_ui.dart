import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'feeds_screen.dart';
import 'getPromo.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


Widget rectCurvedBG(){
  return Container(
      color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(
            color: Colors.black,
            width: 4,
          ),
          borderRadius: BorderRadius.all(Radius.circular(100.0))),
      ),
  );
}

Widget rectBG(){
  return Container(
    color: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(
            color: Colors.black,
            width: 4,
          ),
    ),
    ),
  );
}


class HomeScreenUI extends StatelessWidget {
  final Firestore databaseReference  = Firestore.instance;

  //constructor
  HomeScreenUI();

  //build function
  @override
  Widget build(BuildContext context) {
    //testing

    return Stack(
      children: <Widget>[
        //feeds bg rectangle
        Positioned(
          left: 225,
          top: 180,
          right: 20,
          bottom: 20,
          child: rectBG(),
        ),
        //homescreen bg rectangle
        Positioned(
          left: 20,
          top: 180,
          right: 215,
          bottom: 20,
          child: rectBG(),
        ),
        Positioned(
          left: 20,
          top: 10,
          right: 20,
          bottom: 375,
          child: rectCurvedBG(),
        ),
        //position feeds
        Positioned(
          left: 255,
          top: 190,
          right: 10,
          bottom: 10,
          child: FeedsScreen(),
        ),
        //position home screen
        Positioned(
          left: 50,
          top: 190,
          right: 10,
          bottom: 10,
          child: HomeScreen(),
        ),
        //position Promo text
        Positioned(
          left: 150,
          top: 90,
          right: 10,
          bottom: 10,
          child: GetPromo(),
        ),
      ],
    );
  }
}
