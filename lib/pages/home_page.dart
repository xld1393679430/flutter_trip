import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/pages/webview.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:toast/toast.dart';

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

  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel gridNavLit;
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBox;
  bool _loading = true;

  Future<Null> _handleRefresh({isRefresh = true}) async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        gridNavLit = model.gridNav;
        subNavList = model.subNavList;
        salesBox = model.salesBox;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
    if (isRefresh) {
      Toast.show("刷新完成", context);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    _handleRefresh(isRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: [
              MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: NotificationListener(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification &&
                            scrollNotification.depth == 0) {
                          // 滚动且是列表滚动的时候
                          _handleScroll(scrollNotification.metrics.pixels);
                        }
                        return false;
                      },
                      child: _listView,
                    ),
                  )),
              _appBar,
            ],
          ),
        ));
  }

  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                CommonModel model = bannerList[index];
                return WebView(
                  url: model.url,
                  title: model.title,
                  hideAppBar: model.hideAppBar,
                );
              }));
            },
            child: Image.network(bannerList[index].icon, fit: BoxFit.fill),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  Widget get _listView {
    return ListView(
      children: [
        _banner,
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: LocalNav(localNavList: localNavList)),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: GridNav(
              gridNavModel: gridNavLit,
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: SubNav(
              subNavList: subNavList,
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: SalesBox(
              salesBox: salesBox,
            )),
        Container(
          child: Text("result2"),
        )
      ],
    );
  }

  Widget get _appBar {
    return Opacity(
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
    );
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
