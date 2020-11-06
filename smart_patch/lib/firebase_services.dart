import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_patch/tweet_model.dart';

class FirebaseServices {
    FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;
    String collectionName;

    FirebaseServices(this.collectionName);

    Stream<List<TweetModel>> getTweetList() {
<<<<<<< HEAD
      return _fireStoreDataBase.collection(collectionName)
          .snapshots()
          .map((snapShot) =>
          snapShot.docs
              .map((document) => TweetModel.fromJson(document.data()))
              .toList());
=======
        return _fireStoreDataBase.collection(collectionName)
            .snapshots()
            .map((snapShot) =>
            snapShot.documents
                .map((document) => TweetModel.fromJson(document.data))
                .toList());
>>>>>>> master
    }
}