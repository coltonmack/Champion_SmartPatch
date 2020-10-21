import 'package:flutter/material.dart';
import 'package:smart_patch/firebase_services.dart';
import 'loads_tweets.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoadTweets("Champion", "Champion.png"),
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
                  builder: (context) => LoadTweets("SmartPatch", "hashtag.jpg"),
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
