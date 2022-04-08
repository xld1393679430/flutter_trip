import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/full_screen_page.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

var _currentIndex = 0;

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(initialPage: _currentIndex);
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _controller,
          children: [
            HomePage(),
            SearchPage(
              hideLeft: true,
            ),
            TravelPage(),
            MyPage(),
            FullScreenPage(),
          ],
          physics: NeverScrollableScrollPhysics(), // 禁止PageView左右滑动
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _renderNavigationBarItem(Icons.home, "首页", 0),
            _renderNavigationBarItem(Icons.search, "搜素", 1),
            _renderNavigationBarItem(Icons.camera_alt, "旅拍", 2),
            _renderNavigationBarItem(Icons.account_circle, "我的", 3),
            _renderNavigationBarItem(Icons.fullscreen, "全面屏", 4),
          ],
        ),
      ),
    );
  }

  _renderNavigationBarItem(icon, title, index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex == index ? _activeColor : _defaultColor),
        ));
  }
}
