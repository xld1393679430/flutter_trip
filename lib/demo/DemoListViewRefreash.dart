import 'package:flutter/material.dart';

class DemoListViewRefresh extends StatefulWidget {
  @override
  _DemoListViewRefreshState createState() => _DemoListViewRefreshState();
}

class _DemoListViewRefreshState extends State<DemoListViewRefresh> {
  List<String> cityNames = [
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

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData();
      }
    });
    super.initState();
  }

  // 记得在组件卸载时卸载ScrollController
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("列表上拉加载 & 下拉刷新功能"),
          ),
          body: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: ListView(
              controller: _scrollController,
              children: _buildList(),
            ),
          )),
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      cityNames = cityNames.reversed.toList();
    });
  }

  List<Widget> _buildList() {
    return cityNames.map((city) => _buildItem(city)).toList();
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

  _loadData() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      List<String> list = List.from(cityNames);
      list.addAll(cityNames);
      cityNames = list;
    });
  }
}
