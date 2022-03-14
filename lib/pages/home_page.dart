import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController(initialPage: 0);
  List _imageUrls = [
    'https://fc6tn.baidu.com/it/u=987527054,2646720927&fm=202&src=801',
    'https://dss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=118881608,3318206437&fm=202&src=801',
    'https://fc3tn.baidu.com/it/u=1680718296,1138241536&fm=202&src=801'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 160,
              child: Swiper(
                itemCount: _imageUrls.length,
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(_imageUrls[index], fit: BoxFit.fill);
                },
                pagination: SwiperPagination(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
