import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_patch/firebase_services.dart';
import 'package:smart_patch/tweet_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadTweets extends StatefulWidget {
  final String collectionName;
  final String imageName;
  List tweetList;
  FirebaseServices firebaseServices;

  LoadTweets(this.collectionName, this.imageName) {
    firebaseServices = FirebaseServices(collectionName);
  }

  @override
  LoadTweetsState createState() => LoadTweetsState();
}

class LoadTweetsState extends State<LoadTweets> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TweetModel>>(
        initialData: List(),
        create: (BuildContext context) =>
            widget.firebaseServices.getTweetList(),
        child: ViewTweetPage(widget.imageName));
  }
}

class ViewTweetPage extends StatelessWidget {
  final String imageName;

  ViewTweetPage(this.imageName);

  @override
  Widget build(BuildContext context) {
    List tweetList = Provider.of<List<TweetModel>>(context);

    return tweetList.isEmpty
        ? SpinKitFadingCircle(color: Colors.black, size: 100)
        : Scaffold(
            body: ListView.builder(
              itemCount: tweetList.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Image.asset(
                    "assets/" + imageName,
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
                ),
              ),
            ),
          );
  }
}
