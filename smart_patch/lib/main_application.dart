import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera_screen.dart';
import 'home_screen.dart';
import 'feeds_screen.dart';

var firstCamera;

class mainApp extends StatefulWidget {

  @override
  mainAppState createState() => mainAppState();
}

class mainAppState extends State<mainApp> {

  @override
  void initState() {
    initializeCamera();
    super.initState();
  }

  Future initializeCamera() async {
    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    firstCamera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    CameraScreen(camera: firstCamera),
    HomeScreen(),
    FeedsScreen(),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleNames.elementAt(_screenIndex))),
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
