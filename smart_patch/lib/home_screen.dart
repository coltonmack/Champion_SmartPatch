import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Text("Home Screen"),
        Image.asset('assets/Champion.png')
      ]),
	  /**********************adding drawer to home page only for now******************/
		drawer: Drawer(								//endDrawer puts it on the right
			child: ListView(
				padding: EdgeInsets.zero,
				children: const <Widget>[
					DrawerHeader(
						decoration: BoxDecoration(
							color: Colors.blue,
						),
						child: Text(
							'Menu',
							style: TextStyle(
							  color: Colors.white,
							  fontSize: 24,
							),
						),
					),
					ListTile(
						leading: Icon(Icons.account_circle),
						title: Text('Account'),						//need to add stuff here
					),
					ListTile(
						leading: Icon(Icons.settings),
						title: Text('Settings'),
						/*onTap: (){
							//
							Navigator.pop(context); 
						},*/
					),
				],
			),
		),
    );
  }
}
