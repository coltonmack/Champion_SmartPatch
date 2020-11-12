import 'package:flutter/material.dart';
import 'getPromo.dart';
import 'home_screen.dart';
import 'feeds_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenUI extends StatelessWidget {
  final FirebaseFirestore databaseReference = FirebaseFirestore.instance;

//constructor
  HomeScreenUI();

//build function
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

                  child: HomeScreen())
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
/*
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
  final FirebaseFirestore databaseReference  = FirebaseFirestore.instance;

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
        //position feeds
        Positioned(
          left: 255,
          top: 190,
          right: 10,
          bottom: 10,
          child: FeedsScreen(),
        ),
      ],
    );
  }
}
*/
