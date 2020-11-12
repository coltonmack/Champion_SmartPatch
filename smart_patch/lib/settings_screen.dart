import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth;
  var userId;
  final _controller = TextEditingController();
  var inputText;
  bool interestSports = false;
  bool interestGaming = false;
  bool interestMusic = false;
  bool interestFashion = false;

  PreferencesScreen(this.auth);

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  void loadUserSettings() async {
    widget.userId = widget.auth.currentUser.uid.toString();
    var userRef = await widget.db.collection('Users').doc(widget.userId);
    userRef.get().then((snapshot) {
      Map<dynamic, dynamic> userData = snapshot.data();
      setState(() {
        widget._controller.text = userData["Hashtags"];
        widget.inputText = widget._controller.text;
        widget.interestSports = userData["Sports"];
        widget.interestGaming = userData["Gaming"];
        widget.interestMusic = userData["Music"];
        widget.interestFashion = userData["Fashion"];
      });
    });
  }

  @override
  void initState() {
    loadUserSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          widget.db.collection("Users").doc(widget.userId).update({
            "Hashtags": widget.inputText,
            "Sports": widget.interestSports,
            "Gaming": widget.interestGaming,
            "Music": widget.interestMusic,
            "Fashion": widget.interestFashion,
          });

          Navigator.pop(context, false);
          return;
        },
        child: Scaffold(
          backgroundColor: Color.fromARGB(150, 1, 20, 122),
          appBar: AppBar(
              title: Text('Preferences'),
              backgroundColor: Color.fromARGB(150, 1, 20, 122)),
          body: Center(
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: 8, bottom: 30, left: 30, right: 30),
                    child: TextField(
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        controller: widget._controller,
                        decoration: InputDecoration(
                            labelText: 'Enter hashtags',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        onChanged: (text) {
                          widget.inputText = text;
                        })),
                Padding(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 4, left: 30, right: 30),
                    child: Container(
                        color: Colors.red,
                        child: CheckboxListTile(
                          title: const Text('Sports',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          value: widget.interestSports,
                          onChanged: (bool value) {
                            setState(() {
                              widget.interestSports = value ? true : false;
                            });
                          },
                        ))),
                Padding(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 4, left: 30, right: 30),
                    child: Container(
                        color: Colors.red,
                        child: CheckboxListTile(
                          title: const Text('Gaming',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          value: widget.interestGaming,
                          onChanged: (bool value) {
                            setState(() {
                              widget.interestGaming = value ? true : false;
                            });
                          },
                        ))),
                Padding(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 4, left: 30, right: 30),
                    child: Container(
                        color: Colors.red,
                        child: CheckboxListTile(
                          title: const Text('Music',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          value: widget.interestMusic,
                          onChanged: (bool value) {
                            setState(() {
                              widget.interestMusic = value ? true : false;
                            });
                          },
                        ))),
                Padding(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 4, left: 30, right: 30),
                    child: Container(
                        color: Colors.red,
                        child: CheckboxListTile(
                          title: const Text('Fashion',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          value: widget.interestFashion,
                          onChanged: (bool value) {
                            setState(() {
                              widget.interestFashion = value ? true : false;
                            });
                          },
                        ))),
              ],
            ),
          ),
        ));
  }
}

///////////MyAccounts
class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(150, 1, 20, 122),
      appBar: AppBar(
          title: Text('My Account'),
          backgroundColor: Color.fromARGB(150, 1, 20, 122)),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: 8, bottom: 4, left: 30, right: 30),
                child: Image.asset('assets/Champion_text.png')),
          ],
        ),
      ),
    );
  }
}
