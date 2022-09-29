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
  
  DateTime timeBackPressed = DateTime.now();
  late WebViewController controllerGlobal;
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
     
          return false;
        } else {
          if (isExitWarning) {
            const message = 'Press back again to exit';
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
              message,
            )));
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
