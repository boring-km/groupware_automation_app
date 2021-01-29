import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

String _name = "";
String _password = "";

class WebPageApp extends StatelessWidget {

  WebPageApp(String name, String password) {
    _name = name;
    _password = password;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<WebViewController> controller = Completer<WebViewController>();
  WebViewController webViewController;
  FlutterWebviewPlugin flutterWebviewPlugin;
  WebView webView;
  int check = 0;
  @override
  void initState() {
    super.initState();
    webView = WebView(
      initialUrl: 'http://gw.unipoint.co.kr',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (context) {
        this.controller.complete(context);
        webViewController = context;
      },
    );
    Timer(
      Duration(seconds: 2), () {
        webViewController.evaluateJavascript("document.getElementById('UserName').value = '$_name';");
        webViewController.evaluateJavascript("document.getElementById('Password').value = '$_password';");
        webViewController.evaluateJavascript("document.getElementsByTagName('a')[0].click();");
      }
    );
    Timer(
      Duration(seconds: 5), () {
        webViewController.evaluateJavascript(
            "if(document.getElementsByClassName('time_num')[0].textContent != '')"
                " document.getElementById('btnAttOut').click(); "
            "else"
                " document.getElementById('btnAttIn').click();");
      }
    );
    Timer(
      Duration(seconds: 7), () {
        if(Platform.isAndroid) {
          SystemNavigator.pop();
        } else {
          exit(0);
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: webView,
      ),
    );
  }
}