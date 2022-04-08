import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5',
  'm.ctrip.com/html5/',
];

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(
      {this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webViewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _urlChanged;
  StreamSubscription<WebViewStateChanged> _stateChanged;
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    webViewReference.close();
    _urlChanged = webViewReference.onUrlChanged.listen((String url) {});

    _stateChanged =
        webViewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          // if (_isToMain(state.url) && !exiting) {
          //   if (widget.backForbid) {
          //     webViewReference.launch(widget.url);
          //   } else {
          //     Navigator.pop(context);
          //     exiting = true;
          //   }
          // }
          break;
        default:
          break;
      }
    });
  }

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url.indexOf(value) > -1 ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColor = widget.statusBarColor ?? "ffffff";
    Color backButtonColor;
    if (statusBarColor == '#ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    // 颜色转换成16位 => Color(int.parse('0xff' + statusBarColor)
    return Scaffold(
      body: Column(
        children: [
          _appBar(Color(int.parse('0xff' + statusBarColor)), backButtonColor),
          Expanded(
              child: (WebviewScaffold(
            url: widget.url,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text("Loading......"),
              ),
            ),
          )))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _urlChanged.cancel();
    _stateChanged.cancel();

    webViewReference.dispose();
    super.dispose();
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        decoration: BoxDecoration(
            color: widget.statusBarColor != null
                ? Color(int.parse('0xff' + widget.statusBarColor))
                : backButtonColor),
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.title ?? '',
                    style: TextStyle(color: backButtonColor, fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
