import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Feeds.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Champion SmartPatch',
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({Key key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _screenIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Camera Goes Here!',
      style: optionStyle,
    ),
    Column(children: <Widget>[
      Text('Home Page!', style: optionStyle),
      Image.asset('assets/Champion.png'),
    ]),
    //this calls the build function in Feeds.dart constructing this column
    Feeds(),
  ];

  /*
  Column(children: <Widget>[
      const SizedBox(height: 30), RaisedButton(
        onPressed: () {
          launch('https://www.instagram.com/champion/?hl=en');
        },
        child: const Text('Instagram', style: optionStyle)
      ),
    ]),
   */

  void _onItemTapped(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Champion SmartPatch")),
      body: Center(
        child: _widgetOptions.elementAt(_screenIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            title: Text('Scan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cast_connected),
            title: Text('Feeds'),
          ),
        ],
        currentIndex: _screenIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
