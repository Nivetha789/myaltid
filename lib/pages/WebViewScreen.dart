import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myaltid/reasuable/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'kyc.dart';

class WebViewScreen extends StatefulWidget {
  String? url, Kyc;

  WebViewScreen(this.url,this.Kyc);

  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _completer =
  Completer<WebViewController>();
  WebViewController? _webViewController;
  WebView? webView;

  String requestId = "";
  String status = "";

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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.black, buttoncolor]),
          ),
        ),
        elevation: 4.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text("Verify Aadhaar",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontFamily: 'montserrat',
            )),
        centerTitle: false,
        // iconTheme: IconThemeData(color: Style.colors.logoRed),
        backgroundColor: buttoncolor,
        // brightness: Brightness.light,
      ),
      body:Container(
          child: WebView(
              debuggingEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels:  [
              JavascriptChannel(
                  name: 'Print',
                  onMessageReceived: (JavascriptMessage message) {
                    print('Message: ${message.message}');
                  }),
            ].toSet(),
              onWebViewCreated: (controller) async {
                _completer.complete(controller);
              },
            // navigationDelegate: (NavigationRequest request) {
            //   if (request.url.startsWith('https://www.youtube.com/')) {
            //     print('blocking navigation to $request}');
            //     return NavigationDecision.prevent;
            //   }
            //   print('allowing navigation to $request');
            //   return NavigationDecision.navigate;
            // },
            onPageStarted: (String url) {
                if (url.startsWith('https://www.google.com/')) {
                  var uri = Uri.dataFromString(url); //converts string to a uri
                  Map<String, String> params = uri.queryParameters; // query parameters automatically populated
                  requestId = params['requestId']!; // return value of parameter "param1" from uri
                  status = params['status']!;

                  // print(jsonEncode(params));
                  print("requestId - " + requestId);
                  print("status - " + status);

                  if(status == "success"){
                    Navigator.of(context).pop({'status': status, 'requestId': requestId });
                  }else if(status=="error"){
                    Navigator.of(context).pop({'status': status, 'requestId': "" });
                  }
                }
              print('Pagestartedloading: $url');
            },
            onPageFinished: (String url) async {
              // print('Pagefinishedloading: $url');

              final response = await _webViewController?.runJavascriptReturningResult("document.documentElement.innerText");
              print(jsonDecode(response!));
            },
            gestureNavigationEnabled: true,
          )),
    );
  }
}