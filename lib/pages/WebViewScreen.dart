import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  String? url;

  WebViewScreen(this.url);

  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _completer =
  Completer<WebViewController>();
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    print("webview"+widget.url.toString());

    // controller = WebViewController()
    //   ..loadRequest(
    //     Uri.parse(widget.url!),
    //   );
  }

  @override
  Widget build(BuildContext context) {
    _completer.future.then((controller) {
      _webViewController = controller;
      _webViewController!.loadUrl(widget.url.toString());
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFA020F0),
          ),
        ),
        title: Text("MyAltId",
            style: const TextStyle(
              color: Color(0xFFA020F0),
              fontSize: 17.0,
              fontFamily: 'montserrat',
            )),
        centerTitle: false,
        // iconTheme: IconThemeData(color: Style.colors.logoRed),
        backgroundColor: Colors.green,
        // brightness: Brightness.light,
      ),
      body:Container(
          child: WebView(
              debuggingEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) async {
                _completer.complete(controller);
              })),
    );
  }
}