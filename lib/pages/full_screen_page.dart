import 'package:flutter/material.dart';

// 全面屏适配
class FullScreenPage extends StatefulWidget {
  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

// 方法1 使用SafeArea Widget
// class _FullScreenPageState extends State<FullScreenPage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: "全面屏适配",
//         theme: ThemeData(primarySwatch: Colors.blue),
//         home: Container(
//           decoration: BoxDecoration(color: Colors.white),
//           child: SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [Text("顶部"), Text('底部')],
//             ),
//           ),
//         ));
//   }
// }

// 方法2 使用MediaQuery.of(context).padding
class _FullScreenPageState extends State<FullScreenPage> {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return MaterialApp(
        title: "全面屏适配",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Container(
          padding: EdgeInsets.fromLTRB(0, padding.top, 0, padding.bottom),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("顶部1"),
              Container(
                child: Text(
                  '适配全面屏顶部和底部的安全距离',
                  style: TextStyle(fontSize: 16, color: Colors.black38),
                ),
              ),
              Text('底部')
            ],
          ),
        ));
  }
}
