import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'main.dart';
/***********************settings screens*************************/
class SettingsVariable{
	static bool interestSports;
	static bool interestGaming;
	static bool interestMusic;
	static bool interestFashion;
}

///////////////////Preferences
class PreferencesScreen extends StatefulWidget {
	@override
	_PreferencesScreenState createState() => _PreferencesScreenState();

}

class _PreferencesScreenState extends State<PreferencesScreen>{
  
  @override
  Widget build(BuildContext context) {
	return Scaffold(
      appBar: AppBar(title: Text('Preferences')),
	  body: Center(
          child: ListView(
			children: <Widget>[
				TextField(
					decoration: InputDecoration(
					labelText: 'Enter hashtags'
					),
				),
				CheckboxListTile(
					title: const Text('Sports'),
					value: SettingsVariable.interestSports != true,
					onChanged: (bool value) {
						setState(() {
							SettingsVariable.interestSports = value ? false : true;
						});
					},
				),
				CheckboxListTile(
					title: const Text('Gaming'),
					value: SettingsVariable.interestGaming != true,
					onChanged: (bool value) {
						setState(() {
							SettingsVariable.interestGaming = value ? false : true;
						});
					},
				),
				CheckboxListTile(
					title: const Text('Music'),
					value: SettingsVariable.interestMusic != true,
					onChanged: (bool value) {
						setState(() {
							SettingsVariable.interestMusic = value ? false : true;
						});
					},
				),
				CheckboxListTile(
					title: const Text('Fashion'),
					value: SettingsVariable.interestFashion != true,
					onChanged: (bool value) {
						setState(() {
							SettingsVariable.interestFashion = value ? false : true;
						});
					},
				),
			
			],
		  ),
        ),
    );
	
  }
}
///////////MyAccounts
class AccountScreen extends StatefulWidget {
	@override
	_AccountScreenState createState() => _AccountScreenState();

}

class _AccountScreenState extends State<AccountScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Account')),
	  body: Center(
		child: ListView(
			children: <Widget>[
			Padding(
            padding: EdgeInsets.only(
            top: 8, bottom: 4, left: 30, right: 30),
            child: Image.asset('assets/Champion_text.png')),
			],
		),
	  ),
    );
	
	
  }
}
