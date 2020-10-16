class TweetModel {
  String author;
  String text;

  TweetModel({this.author, this.text});

  TweetModel.fromJson(Map<String, dynamic> parsedJson):
    text = parsedJson['Tweet'],
    author = parsedJson["Author"];

}