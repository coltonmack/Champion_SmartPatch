import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetPromo extends StatelessWidget {
  final Firestore databaseReference  = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder(
          stream: databaseReference.collection('Promos').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Text('Loading...');
            return Text(snapshot.data.documents[0]['promo1'].toString());
          },
       )
    );
  }
}