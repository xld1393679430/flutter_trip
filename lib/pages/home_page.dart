import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/home_model.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController(initialPage: 0);
  double appBarOpacity = 0;
  List _imageUrls = [
    'https://fc6tn.baidu.com/it/u=987527054,2646720927&fm=202&src=801',
    'https://dss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=118881608,3318206437&fm=202&src=801',
    'https://fc3tn.baidu.com/it/u=1680718296,1138241536&fm=202&src=801'
  ];

  String resultString = "";

  loadData() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(model.config);
      });
    } catch (e) {
      setState(() {
        resultString = "Error: " + e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  // 滚动且是列表滚动的时候
                  _handleScroll(scrollNotification.metrics.pixels);
                }
                return false;
              },
              child: ListView(
                children: [
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(_imageUrls[index],
                            fit: BoxFit.fill);
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text(resultString),
                    ),
                  )
                ],
              ),
            )),
        Opacity(
          opacity: appBarOpacity,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("首页"),
              ),
            ),
          ),
        )
      ],
    ));
  }

  void _handleScroll(double offset) {
    double opacity = offset / APPBAR_SCROLL_OFFSET;
    if (opacity < 0) {
      opacity = 0;
    } else if (opacity > 1) {
      opacity = 1;
    }
    setState(() {
      appBarOpacity = opacity;
    });
  }
}
