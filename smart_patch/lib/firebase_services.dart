import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_patch/tweet_model.dart';

class FirebaseServices {
    Firestore _fireStoreDataBase = Firestore.instance;
    String collectionName;

    FirebaseServices(this.collectionName);

    Stream<List<TweetModel>> getTweetList() {
        return _fireStoreDataBase.collection(collectionName)
            .snapshots()
            .map((snapShot) =>
            snapShot.documents
                .map((document) => TweetModel.fromJson(document.data))
                .toList());
    }
}