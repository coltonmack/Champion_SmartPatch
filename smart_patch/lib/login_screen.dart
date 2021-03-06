import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_patch/main_application.dart';
import 'main_application.dart';

class LoginScreen extends StatefulWidget {
  var camera;

  LoginScreen(this.camera);

  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  int login = 0;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreenState() {
    auth.authStateChanges().listen((User user) {
      print(auth.currentUser);
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          login = 0;
        });
      } else {
        print('User is signed in!');
        setState(() {
          login = 1;
        });
      }
    });
  }

  void attemptLogin(BuildContext context) async {
    if (usernameController.text.length == 0) {
      notifyBadLogin(context, 0);
      return;
    }
    if (passwordController.text.length == 0) {
      notifyBadLogin(context, 1);
      return;
    } else {
      try {
        renderLoadingDialog(context);
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: usernameController.text, password: passwordController.text);
        Navigator.of(context, rootNavigator: true).pop();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          notifyBadLogin(context, 0);
        } else if (e.code == 'user-not-found') {
          notifyBadLogin(context, 2);
        } else if (e.code == 'wrong-password') {
          notifyBadLogin(context, 3);
        }
      }
    }
  }

  Widget renderLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              backgroundColor: Colors.black54,
              children: <Widget>[
                Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please Wait....",
                      style: TextStyle(color: Colors.blueAccent),
                    )
                  ]),
                )
              ]);
        });
  }

  Widget getDismiss(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
        child: Text("Dismiss"));
  }

  Widget getLoginMessage(int errorCode) {
    if (errorCode == 0) return Text("Please insert a valid email");
    if (errorCode == 1) return Text("Please insert a valid password");
    if (errorCode == 2) return Text("No user found for that email");
    if (errorCode == 3) return Text("Incorrect password for given user");
  }

  Widget notifyBadLogin(BuildContext context, int errorCode) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Notice"),
              content: getLoginMessage(errorCode),
              actions: [getDismiss(context)]);
        });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (login == 0) {
      return MaterialApp(
          title: 'Champion SmartPatch',
          home: Scaffold(
              backgroundColor: Color.fromARGB(150, 1, 20, 122),
              appBar: AppBar(
                  title: Text("Sign In"),
                  backgroundColor: Color.fromARGB(150, 1, 20, 122)),
              body: Builder(
                builder: (context) => ListView(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 4, left: 30, right: 30),
                      child: Image.asset('assets/Champion_text.png')),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 4, bottom: 4, left: 30, right: 30),
                      child: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                              labelText: 'Email:',
                              labelStyle: TextStyle(color: Colors.red),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          style: TextStyle(fontSize: 18, color: Colors.white))),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 4, bottom: 30, left: 30, right: 30),
                      child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: 'Password:',
                              labelStyle: TextStyle(color: Colors.red),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          style: TextStyle(fontSize: 18, color: Colors.white))),
                  MaterialButton(
                      onPressed: () {
                        attemptLogin(context);
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                          decoration: const BoxDecoration(color: Colors.red),
                          padding: const EdgeInsets.all(15.0),
                          child:
                              Text('Sign In', style: TextStyle(fontSize: 20)))),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 16, bottom: 4, left: 20, right: 20),
                      child: Center(
                          child: Text("or use a social profile",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white)))),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 4, left: 20, right: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                              onPressed: () {},
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.lightBlueAccent),
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text('Twitter',
                                      style: TextStyle(fontSize: 20)))),
                          MaterialButton(
                              onPressed: () {},
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 10, 50, 120)),
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text('Facebook',
                                      style: TextStyle(fontSize: 20)))),
                        ]),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 4, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          MaterialButton(
                              onPressed: () {},
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.red),
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text('Sign Up',
                                      style: TextStyle(fontSize: 20)))),
                        ],
                      ))
                ]),
              )));
    } else {
      return mainApp(auth: auth, camera: widget.camera);
    }
  }
}
