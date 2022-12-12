import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'home_screens/home_tab_screen.dart';

class WebView extends StatefulWidget {
  final String url;
  final String title;
  const WebView({Key? key, required this.url, required this.title,}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  double _progress = 0;
  late InAppWebViewController webViewController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (ctx) => HomeTabScreen(
                      pageIndex: 0,
                    )),
            (route) => false);
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
            size: 25,
          ),
        ),
        body: Stack(
          children: <Widget>[
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.url),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
            ),
            _progress < 1
                ? SizedBox(
                    height: 3,
                    child: LinearProgressIndicator(
                      value: _progress,
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
