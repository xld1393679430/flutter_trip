import 'package:flutter/material.dart';

// 跳转指定页面
class NavigatorUtil {
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
