import "dart:convert";

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _showResult = "";

  Future<CommonModel> fetchPost() async {
    final response = await http
        .get("http://www.devio.org/io/flutter_app/json/test_common_model.json");
    Utf8Decoder utf8Decoder = Utf8Decoder(); // 中文字符正常显示
    final result = json.decode(utf8Decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Http & Future"),
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                fetchPost().then((CommonModel value) {
                  setState(() {
                    _showResult =
                        "请求结果：\n icon:${value.icon}\n title:${value.title}\n url:${value.url}\n statusBarColor:${value.statusBarColor}\n hideAppBar:${value.hideAppBar}";
                  });
                });
              },
              child: Text(
                "点我",
                style: TextStyle(fontSize: 26),
              ),
            ),
            Text(_showResult),
            Text('-----------------'),
            FutureBuilder<CommonModel>(
                future: fetchPost(),
                builder: (BuildContext context,
                    AsyncSnapshot<CommonModel> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("None");
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.active:
                      return Text("Active");
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}",
                            style: TextStyle(color: Colors.red));
                      } else {
                        return Column(
                          children: [
                            Text("icon: ${snapshot.data.icon}"),
                            Text("title: ${snapshot.data.title}"),
                            Text("url: ${snapshot.data.url}"),
                            Text(
                                "statusBarColor: ${snapshot.data.statusBarColor}"),
                            Text("hideAppBar: ${snapshot.data.hideAppBar}"),
                          ],
                        );
                      }
                  }

                  return null;
                })
          ],
        ),
      ),
    );
  }
}

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}
