import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Column(children: <Widget>[
        Text("Home Screen"),
        Image.asset('assets/Champion.png')
      ]),
    );
  }
}
