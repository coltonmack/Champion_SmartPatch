import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedsScreen extends StatelessWidget {
  //constructor
  FeedsScreen();

  //build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(children: <Widget>[
        GestureDetector(
            onTap: () {
              launch('https://www.twitch.tv/');
            },
            child: Image.asset(
              'assets/twitch_logo.png',
              fit: BoxFit.fill,
              width: 75,
              height: 75,
            )),
        GestureDetector(
            onTap: () {
              launch('https://www.instagram.com/champion/?hl=en');
            },
            child: Image.asset(
              'assets/insta_logo_1.png',
              fit: BoxFit.fill,
              width: 100,
              height: 100,
            )),
        GestureDetector(
            onTap: () {
              launch('https://www.youtube.com/');
            },
            child: Image.asset(
              'assets/yt_logo.png',
              fit: BoxFit.fill,
              width: 95,
              height: 75,
            )),
        GestureDetector(
            onTap: () {
              launch('https://www.facebook.com/champion/');
            },
            child: Image.asset(
              'assets/fb_logo.png',
              fit: BoxFit.fill,
              width: 80,
              height: 80,
            )),
      ]),
    );
  }
}
