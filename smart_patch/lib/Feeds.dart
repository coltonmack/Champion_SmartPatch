import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Feeds extends StatelessWidget{
  //constructor
  Feeds();

  //build function
  @override
  Widget build(BuildContext context){
    return Column(children: <Widget>[
      GestureDetector(
          onTap: () {
            launch('https://www.instagram.com/champion/?hl=en');
          },
          child: Image.asset(
            'assets/insta_logo.png',
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          )
      ),
      GestureDetector(
          onTap: () {
            launch('https://www.facebook.com/champion/');
          },
          child: Image.asset(
            'assets/fb_logo.png',
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          )
      ),
      GestureDetector(
          onTap: () {
            launch('https://twitter.com/ChampionUSA?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor');
          },
          child: Image.asset(
            'assets/twitter_logo.png',
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          )
      ),
    ]);
  }
}
