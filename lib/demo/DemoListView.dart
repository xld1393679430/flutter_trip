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
  "呼和浩特"
];

class DemoListView extends StatefulWidget {
  @override
  State<DemoListView> createState() => _DemoListViewState();
}

class _DemoListViewState extends State<DemoListView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("DemoListView"),
        ),
        body: Container(
          height: 500,
          child: ListView(
            scrollDirection:
                Axis.vertical, // horizontal：水平方向滚动；vertical: 垂直方向滚动
            children: _buildList(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _buildItem(city)).toList();
  }

  Widget _buildItem(city) {
    return Container(
      height: 100,
      width: 200,
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
