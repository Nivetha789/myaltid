import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlScreen extends StatefulWidget {
  String htmlId;

  HtmlScreen(this.htmlId, {super.key});

  @override
  HtmlScreenState createState() => HtmlScreenState();
}

class HtmlScreenState extends State<HtmlScreen> {
  String htmlContent = "";
  String title = "";

  // WebViewController _webViewController;
  @override
  void initState() {
    super.initState();
    // aboutUsApi();
    // check().then((intenet) {
    //   if (intenet != null && intenet) {
    //     aboutUsApi();
    //   } else {
    //     ToastHandler.showToast(
    //         message: "Please check your internet connection");
    //   }
    // });
  }

  WebViewController? webViewController;
  final staticAnchorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Style.colors.white,
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
        title: Text(title,
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
      body: Container(
        // color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
            child:
                // WebviewScaffold(
                //   url: widget.htmlId,
                //   appBar: AppBar(title: Text('Payment Checkout')),
                //   withJavascript: true,
                //   withZoom: false,

                WebView(
              initialUrl: 'about:blank',
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              onWebViewCreated: (WebViewController webViewController1) {
                // _controller.complete(webViewController1);
                webViewController1.loadUrl(Uri.dataFromString(widget.htmlId,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('utf-8'))
                    .toString());
              },
              // onWebViewCreated: (WebViewController controller) {
              // controller.loadUrl(Uri.dataFromString(widget.htmlId,
              //         mimeType: 'text/html',
              //         encoding: Encoding.getByName('utf-8'))
              //     .toString());
              // },
            ),
            // ignore: avoid_types_as_parameter_names
            // onLinkTap: (Url, _, __, ___) async {
            //   await launchUrl(
            //     Uri.parse(Url!),
            //     mode: LaunchMode.externalApplication,
            //   );
            // },
            // tagsList: Html.tags..addAll(["bird", "flutter"]),
            // style: {
            //   Style()
            // },
            // style: {
            //   "table": Style(fontFamily: 'montserrat', color: Colors.black
            //       // backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
            //       ),
            //   "tr": Style(fontFamily: 'montserrat', color: Colors.black),
            //   "th": Style(fontFamily: 'montserrat', color: Colors.black),
            //   "td": Style(fontFamily: 'montserrat', color: Colors.black),
            //   'h5': Style(fontFamily: 'montserrat', color: Colors.black),
            // },
            // // customRender: {
            // //   "table": (context, child) {
            // //     return SingleChildScrollView(
            // //       scrollDirection: Axis.horizontal,
            // //       child: (context.tree as TableLayoutElement)
            // //           .toWidget(context),
            // //     );
            // //   },
            // //   "bird": (RenderContext context, Widget child) {
            // //     return TextSpan(text: "🐦");
            // //   },
            //   "flutter": (RenderContext context, Widget child) {
            //     return FlutterLogo(
            //       style: (context.tree.element!
            //                   .attributes['horizontal'] !=
            //               null)
            //           ? FlutterLogoStyle.horizontal
            //           : FlutterLogoStyle.markOnly,
            //       textColor: context.style.color!,
            //       // size: context.style.fontSize!.size! * 5,
            //     );
            //   },
            // },
            // onLinkTap: (url, _, __) async {
            //   print(url);
            //   // if (url == "www.siamdealz.com") {
            //   //   await launchUrl(
            //   //     Uri.parse("http://$url"),
            //   //     mode: LaunchMode.externalApplication,
            //   //   );
            //   // } else {
            //   //   await launchUrl(
            //   //     Uri.parse(url!),
            //   //     mode: LaunchMode.externalApplication,
            //   //   );
            //   // }
            //   // if (!url!.startsWith("http://") &&
            //   //     !url.startsWith("https://")) {

            //   // } else {

            //   // }

            //   // debugPrint("Opening $url...");
            // },
            // onImageTap: (src, _, __, ___) {
            //   debugPrint(src);
            // },
            // onImageError: (exception, stackTrace) {
            //   debugPrint(exception);
            // },

            // onTapUrl: (){
            //   url
            // },
            // onTapUrl: (url) async {
            //   await launchUrl(
            //     Uri.parse(url),

            // onTapUrl: (Url) async {
            //  await launchUrl(
            //     Uri.parse(Url),
            //     mode: LaunchMode.externalApplication,
            //   );
            // },
            // onTapUrl: (){
            //   url
            // },
            // onTapUrl: (url) async {
            // await launchUrl(
            //   Uri.parse(url),
            //   mode: LaunchMode.externalApplication,
            // );
            //   debugPrint("Opening $url...");
            // },
            // onCssParseError: (css, messages) {
            //   debugPrint("css that errored: $css");
            //   debugPrint("error messages:");
            //   messages.forEach((element) {
            //     debugPrint(element.toString());
            //   });
            // },
            // ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.event),
      //   onPressed: () {
      //     // Replace the JavaScript code below with your actual code
      //     String javascriptCode =
      //         "document.getElementById('btnSubmit').click();";
      //     executeJavaScript(javascriptCode);

      //     triggerEventInWebView();
      //   },
      // ),
    );
  }

// Future<void> executeJavaScript(String code) async {
//   if (webViewController != null) {
//     await webViewController!.evaluateJavascript(code);
//   }
// }
//
// final Completer<WebViewController> _controller =
//     Completer<WebViewController>();
// void triggerEventInWebView() async {
//   // webViewController = WebViewController();
//   print("gkjhdkghdkjhkdfgkhdf");
//   if (webViewController != null) {
//     print("gkjhdkghdkjhkdfgkhdffgfg");
//     await webViewController!
//         .evaluateJavascript("document.getElementById('btnSubmit').click();");
//   } else {
//     await webViewController!
//         .evaluateJavascript("document.getElementById('btnSubmit').click();");
//   }
// }
// aboutUsApi() async {
//   // ProgressDialog().showLoaderDialog(context);
//   Dio dio = Dio();
//   // String regNo = await SharedPreference().getRegNo();

//   // dio.options.contentType = Headers.formUrlEncodedContentType;

//   debugPrint('response ${ApiProvider.getHtmlContentApi}${widget.htmlId}');

//   final response = await dio.get(
//     ApiProvider.getHtmlContentApi + widget.htmlId,
//     options: Options(contentType: Headers.formUrlEncodedContentType),
//   );

//   if (response.statusCode == 200) {
//     Map<String, dynamic> map = jsonDecode(response.toString());
//     HtmlContentModel aboutUsModel = HtmlContentModel.fromJson(map);

//     if (aboutUsModel.nStatus == 1) {
//       // ProgressDialog().dismissDialog(context);

//       setState(() {
//         title = aboutUsModel.jResult![0].cPages!;
//         htmlContent = aboutUsModel.jResult![0].cDescription!;
//       });
//     } else {
//       ProgressDialog().dismissDialog(context);
//       ToastHandler.showToast(message: aboutUsModel.cMessage!);
//     }
//   } else {
//     ProgressDialog().dismissDialog(context);
//     ToastHandler.showToast(message: "Bad Network Connection try again..");
//   }
// }
}
