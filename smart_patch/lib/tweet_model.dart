class TweetModel {
  String text;
  String author;
  String url;

  TweetModel.fromJson(Map<String, dynamic> parsedJson, String name)
      : this.text = parsedJson['Tweet'],
        this.author = parsedJson['Author'],
        this.url = name;
}

class ChampionTweetModel extends TweetModel {
  ChampionTweetModel.fromJson(Map<String, dynamic> parsedJson)
      : super.fromJson(parsedJson, "assets/Champion.png");
}

class HashtagTweetModel extends TweetModel {
  HashtagTweetModel.fromJson(Map<String, dynamic> parsedJson)
      : super.fromJson(parsedJson, "assets/hashtag.jpg");
}

class SportsTweetModel extends TweetModel {
  SportsTweetModel.fromJson(Map<String, dynamic> parsedJson)
      : super.fromJson(parsedJson, "assets/basketball.png");
}

class GamingTweetModel extends TweetModel {
  GamingTweetModel.fromJson(Map<String, dynamic> parsedJson)
      : super.fromJson(parsedJson, "assets/twitch_logo.png");
}

class MusicTweetModel extends TweetModel {
  MusicTweetModel.fromJson(Map<String, dynamic> parsedJson)
      : super.fromJson(parsedJson, "assets/music.png");
}

class FashionTweetModel extends TweetModel {
  FashionTweetModel.fromJson(Map<String, dynamic> parsedJson)
      : super.fromJson(parsedJson, "assets/fashion.png");
}
