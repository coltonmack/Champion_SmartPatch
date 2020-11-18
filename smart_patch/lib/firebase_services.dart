import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_patch/tweet_model.dart';

class FirebaseServices {
  FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

  Stream<List<ChampionTweetModel>> getChampionTweetList(String collectionName) {
    return _fireStoreDataBase.collection(collectionName).snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => ChampionTweetModel.fromJson(document.data()))
            .toList());
  }

  Stream<List<HashtagTweetModel>> getHashtagTweetList(String collectionName) {
    return _fireStoreDataBase.collection(collectionName).snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => HashtagTweetModel.fromJson(document.data()))
            .toList());
  }

  Stream<List<SportsTweetModel>> getSportsTweetList(String collectionName) {
    return _fireStoreDataBase.collection(collectionName).snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => SportsTweetModel.fromJson(document.data()))
            .toList());
  }

  Stream<List<GamingTweetModel>> getGamingTweetList(String collectionName) {
    return _fireStoreDataBase.collection(collectionName).snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => GamingTweetModel.fromJson(document.data()))
            .toList());
  }

  Stream<List<MusicTweetModel>> getMusicTweetList(String collectionName) {
    return _fireStoreDataBase.collection(collectionName).snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => MusicTweetModel.fromJson(document.data()))
            .toList());
  }

  Stream<List<FashionTweetModel>> getFashionTweetList(String collectionName) {
    return _fireStoreDataBase.collection(collectionName).snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => FashionTweetModel.fromJson(document.data()))
            .toList());
  }
}
