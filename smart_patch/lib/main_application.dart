import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'camera_screen.dart';
import 'website_screen.dart';
import 'home_screen_ui.dart';
import "login_screen.dart";
import "settings_screens.dart";

class mainApp extends StatefulWidget {
  var camera;
  FirebaseAuth auth;

  mainApp({Key key, this.camera, this.auth}) : super(key: key);

  @override
  mainAppState createState() => mainAppState();
}

class mainAppState extends State<mainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomeScreen(camera: widget.camera, auth: widget.auth),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  var camera;
  var auth;

  MyHomeScreen({Key key, this.camera, this.auth}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _screenIndex = 0;
  int login_state = 0;

  //list interests here
  bool interestSports;
  bool interestGaming;
  bool interestMusic;
  bool interestFashion;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold);

  static List<String> _titleNames = <String>[
    "Scan Patch",
    "Home Page",
    "Feeds",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  Widget BuildWidget() {
    if (_screenIndex == 0) return CameraScreen(camera: widget.camera);
    if (_screenIndex == 1) return HomeScreenUI();
    if (_screenIndex == 2) return WebsiteScreen();
  }

  void signOut() async {
    await widget.auth.signOut();
    setState(() {
      login_state = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (login_state == 0) {
      return Scaffold(
        backgroundColor: Color.fromARGB(150, 1, 20, 122),
        appBar: AppBar(
            title: Text(_titleNames.elementAt(_screenIndex)),
            backgroundColor: Color.fromARGB(150, 1, 20, 122)),
        body: Center(
          child: BuildWidget(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(150, 1, 20, 122),
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cast_connected),
              label: 'Web',
            ),
          ],
          currentIndex: _screenIndex,
          selectedItemColor: Colors.red,
          onTap: _onItemTapped,
        ),
        //menu drawer
        drawer: Drawer(
          //endDrawer puts it on the right
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
			  ListTile(
				title: Text('My Account'),
				onTap:(){
					Navigator.push(
						context,
						MaterialPageRoute(
							builder: (context) => AccountScreen(),
						),
					);
					//Navigator.pop(context);
				},
			  ),
			  ListTile(
				title: Text('Preferences'),
				onTap:(){
					Navigator.push(
						context,
						MaterialPageRoute(
							builder: (context) => PreferencesScreen(),
						),
					);
					//Navigator.pop(context);
				},
			  ),
              MaterialButton(
                  onPressed: () {
                    signOut();
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      decoration: const BoxDecoration(color: Colors.red),
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Sign Out', style: TextStyle(fontSize: 20)))),
            ],
          ),
        ),
      );
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}


