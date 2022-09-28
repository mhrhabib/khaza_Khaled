import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Khaza Khaled',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int i = 0;
  DateTime timeBackPressed = DateTime.now();
  late WebViewController controllerGlobal;
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        timeBackPressed = DateTime.now();
        final isExitWarning = difference >= Duration(seconds: 2);

       
          if (await controllerGlobal.canGoBack()) {
            controllerGlobal.goBack();
            i = 0;
            return false;
          } else {
            if (i == 0) {
              setState(() {
                i = 1;
              });
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyHomePage1(),
                ),
              );
              return false;
            } else {
              return true;
            }
          }
        
      },
      child: Scaffold(
        body: SafeArea(
          child: WebView(
            onWebViewCreated: (WebViewController webViewController) {
              controllerGlobal = webViewController;
            },
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'https://khazakhaled.com/',
          ),
        ),
      ),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key? key}) : super(key: key);

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  late WebViewController controllerGlobal;
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();
  DateTime timeBackPressed = DateTime.now();
  int i = 0;
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        timeBackPressed = DateTime.now();
        final isExitWarning = difference >= Duration(seconds: 2);

   
          if (await controllerGlobal.canGoBack()) {
            controllerGlobal.goBack();
            i = 0;
            return false;
          } else {
            if (i == 0) {
              setState(() {
                i = 1;
              });
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyHomePage1(),
                ),
              );
              return false;
            } else {
              return true;
            }
          }
        
      },
      child: Scaffold(
        body: SafeArea(
          child: WebView(
            onWebViewCreated: (WebViewController webViewController) {
              controllerGlobal = webViewController;
            },
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'https://khazakhaled.com/',
          ),
        ),
      ),
    );
  }
}
