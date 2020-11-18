import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_patch/firebase_services.dart';
import 'package:smart_patch/tweet_model.dart';

class LoadTweets extends StatefulWidget {
  final bool picker;
  FirebaseAuth auth;
  FirebaseServices firebaseServices;

  LoadTweets(this.picker, this.auth) {
    firebaseServices = FirebaseServices();
  }

  @override
  LoadTweetsState createState() => LoadTweetsState(picker);
}

class LoadTweetsState extends State<LoadTweets> {
  bool picker;

  LoadTweetsState(picker);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider<List<ChampionTweetModel>>(
          initialData: List(),
          create: (BuildContext context) =>
              widget.firebaseServices.getChampionTweetList("Champion")),
      StreamProvider<List<HashtagTweetModel>>(
          initialData: List(),
          create: (BuildContext context) =>
              widget.firebaseServices.getHashtagTweetList("SmartPatch")),
      StreamProvider<List<SportsTweetModel>>(
          initialData: List(),
          create: (BuildContext context) =>
              widget.firebaseServices.getSportsTweetList("Sports")),
      StreamProvider<List<GamingTweetModel>>(
          initialData: List(),
          create: (BuildContext context) =>
              widget.firebaseServices.getGamingTweetList("Gaming")),
      StreamProvider<List<MusicTweetModel>>(
          initialData: List(),
          create: (BuildContext context) =>
              widget.firebaseServices.getMusicTweetList("Music")),
      StreamProvider<List<FashionTweetModel>>(
          initialData: List(),
          create: (BuildContext context) =>
              widget.firebaseServices.getFashionTweetList("Fashion")),
    ], child: ViewTweets(widget.picker, widget.auth));
  }
}

class ViewTweets extends StatefulWidget {
  bool picker;
  FirebaseAuth auth;
  var userId;
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool interestSports = false;
  bool interestGaming = false;
  bool interestMusic = false;
  bool interestFashion = false;

  ViewTweets(this.picker, this.auth);

  @override
  ViewTweetsState createState() => ViewTweetsState();
}

class ViewTweetsState extends State<ViewTweets> {
  List championTweetList;
  List hashtagTweetList;
  List sportsTweetList;
  List gamingTweetList;
  List musicTweetList;
  List fashionTweetList;

  void loadUserSettings() async {
    widget.userId = widget.auth.currentUser.uid.toString();
    var userRef = await widget.db.collection('Users').doc(widget.userId);
    userRef.get().then((snapshot) {
      Map<dynamic, dynamic> userData = snapshot.data();
      if (this.mounted)
        setState(() {
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
    championTweetList = Provider.of<List<ChampionTweetModel>>(context);
    hashtagTweetList = Provider.of<List<HashtagTweetModel>>(context);
    sportsTweetList = Provider.of<List<SportsTweetModel>>(context);
    gamingTweetList = Provider.of<List<GamingTweetModel>>(context);
    musicTweetList = Provider.of<List<MusicTweetModel>>(context);
    fashionTweetList = Provider.of<List<FashionTweetModel>>(context);

    return Scaffold(body: BuildTweetView());
  }

  Widget BuildTweetView() {
    return widget.picker
        ? CustomScrollView(slivers: <Widget>[getSliverList(championTweetList)])
        : CustomScrollView(slivers: <Widget>[
            getSliverList(hashtagTweetList),
            if (widget.interestSports) getSliverList(sportsTweetList),
            if (widget.interestGaming) getSliverList(gamingTweetList),
            if (widget.interestMusic) getSliverList(musicTweetList),
            if (widget.interestFashion) getSliverList(fashionTweetList)
          ]);
  }

  Widget getSliverList(List<TweetModel> tweetList) {
    return SliverList(
        delegate:
            new SliverChildBuilderDelegate((BuildContext context, int index) {
      return new ListTile(
        leading: Image.asset(
          '${tweetList[index].url}',
        ),
        title: Text(
          '${tweetList[index].author}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        subtitle: Text(
          '${tweetList[index].text}',
          style: TextStyle(
            fontSize: 10.0,
          ),
        ),
      );
    }, childCount: tweetList.length));
  }
}
