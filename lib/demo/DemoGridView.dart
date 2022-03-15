import 'package:flutter/material.dart';

const CITY_NAMES = [
  "上海",
  "北京",
  "天津",
  "合肥",
  "苏州",
  "新疆",
  "南京",
  "哈尔滨",
  "重庆",
  "成都",
  "泰州",
  "呼和浩特",
  "安庆"
];

class DemoGridView extends StatefulWidget {
  @override
  _DemoGridViewState createState() => _DemoGridViewState();
}

class _DemoGridViewState extends State<DemoGridView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("网格布局"),
          ),
          body: GridView.count(
            crossAxisCount: 3,
            children: _buildList(),
          )),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _buildItem(city)).toList();
  }

  Widget _buildItem(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
