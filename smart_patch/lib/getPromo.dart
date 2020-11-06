import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

class GetPromo extends StatelessWidget {
  final FirebaseFirestore databaseReference = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: StreamBuilder(
      stream: databaseReference.collection('Promos').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading...', style: TextStyle(color: Colors.white));
        return Text(snapshot.data.documents[0]['promo1'].toString(), style: TextStyle(color: Colors.white));
      },
    ));
  }
}
