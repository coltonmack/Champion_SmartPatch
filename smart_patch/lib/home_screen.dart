import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loads_tweets.dart';

class HomeScreen extends StatefulWidget {
  FirebaseAuth auth;

  HomeScreen(this.auth);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoadTweets(true, widget.auth),
                ),
              );
            },
            child: Image.asset(
              'assets/Champion.png',
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            )),
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoadTweets(false, widget.auth),
                ),
              );
            },
            child: Image.asset(
              'assets/hashtag.jpg',
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            )),
      ]),
    );
  }
}
