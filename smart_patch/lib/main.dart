import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera_screen.dart';
import 'home_screen.dart';
import 'feeds_screen.dart';
import 'website_screen.dart';
import 'home_screen_ui.dart';

var firstCamera;

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;
  runApp(MyApp());
}

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
	//list interests here
	bool interestSports;
	bool interestGaming;
	bool interestMusic;
	bool interestFashion;
	
	
	int _screenIndex = 0;

	static const TextStyle optionStyle =
	  TextStyle(fontSize: 40, fontWeight: FontWeight.bold);


  static List<Widget> _widgetOptions = <Widget>[
    CameraScreen(camera: firstCamera),
		HomeScreenUI(),
    /*HomeScreen(),*/
    /*FeedsScreen(),*/
    WebsiteScreen(),
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
		//menu drawer
		drawer: Drawer(								//endDrawer puts it on the right
			child: ListView(
				padding: EdgeInsets.zero,
				children:  <Widget>[
					DrawerHeader(
						decoration: BoxDecoration(
							color: Colors.blue,
						),
						child: Text(
							'Interests',
							style: TextStyle(
							  color: Colors.white,
							  fontSize: 24,
							),
						),
					),
					/*******************Checkboxes here********************/
					CheckboxListTile(
						title: const Text('Sports'),
						value: interestSports != true,
						onChanged: (bool value) {
							setState(() {
							interestSports = value ? false : true;
							});
						},
					),
					CheckboxListTile(
						title: const Text('Gaming'),
						value: interestGaming != true,
						onChanged: (bool value) {
							setState(() {
							interestGaming = value ? false : true;
							});
						},
					),
					CheckboxListTile(
						title: const Text('Music'),
						value: interestMusic != true,
						onChanged: (bool value) {
							setState(() {
							interestMusic = value ? false : true;
							});
						},
					),
					CheckboxListTile(
						title: const Text('Fashion'),
						value: interestFashion != true,
						onChanged: (bool value) {
							setState(() {
							interestFashion = value ? false : true;
							});
						},
					),			
				],
			),
		),
		
		
    );
  }
}