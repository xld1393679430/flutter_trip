import 'package:flutter/material.dart';

const CITY_NAMES = {
  "北京": [
    "东城区",
    "西城区",
    "朝阳区",
    "丰台区",
  ],
  "上海": [
    "黄浦区",
    "徐汇区",
    "长宁区",
    "静安区",
  ],
  "广州": [
    "越秀",
    "海珠",
    "天河",
    "白云",
  ],
  "深圳": [
    "南山",
    "西城区",
    "朝阳区",
    "丰台区",
  ],
};

class DemoExpansionTitle extends StatefulWidget {
  @override
  _DemoExpansionTitleState createState() => _DemoExpansionTitleState();
}

class _DemoExpansionTitleState extends State<DemoExpansionTitle> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("列表展开与收起"),
        ),
        body: ListView(
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    CITY_NAMES.keys.forEach((key) {
      widgets.add(_buildItem(key, CITY_NAMES[key]));
    });
    return widgets;
  }

  Widget _buildItem(String city, List<String> subCities) {
    return ExpansionTile(
      title: Text(
        city,
        style: TextStyle(color: Colors.black45, fontSize: 20),
      ),
      children: subCities.map((subCity) => _buildSubCity(subCity)).toList(),
    );
  }

  Widget _buildSubCity(String subCity) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
        child: Text(subCity),
      ),
    );
  }
}
