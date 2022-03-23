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
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:toast/toast.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡 景点 酒店 美食';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarOpacity = 0;
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
          height: 200,
          child: Text("result2"),
        )
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: 80,
              decoration: BoxDecoration(
                  color: Color.fromARGB(
                      (appBarOpacity * 255).toInt(), 255, 255, 255)),
              child: SearchBar(
                searchBarType: appBarOpacity > 0.2
                    ? SearchBarType.homeLight
                    : SearchBarType.home,
                inputBoxClick: _jumpToSearch,
                speakClick: _jumpToSpeak,
                defaultText: SEARCH_BAR_DEFAULT_TEXT,
                leftButtonClick: () {},
              )),
        ),
        Container(
          height: appBarOpacity > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
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

  _jumpToSearch() {}

  _jumpToSpeak() {}
}
