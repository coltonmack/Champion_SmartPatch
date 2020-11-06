import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';


class WebsiteScreen extends StatefulWidget {
  @override
  _WebsiteScreenState createState() => _WebsiteScreenState();
}

class _WebsiteScreenState extends State<WebsiteScreen> {

  @override
  void initState() {
    super.initState();
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: 'https://www.champion.com/',
    );
  }
}


/*
class WebsiteScreen extends StatefulWidget {
  //constructor
  WebsiteScreen();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://flutter.dev',
    );
  }
}
*/
