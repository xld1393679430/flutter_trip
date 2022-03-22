import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:http/http.dart' as http;

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

// 首页大接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(HOME_URL);
    // 使用mock数据
    if (false && response.statusCode == 200) {
      Utf8Decoder utf8Decoder = Utf8Decoder(); // 处理中文乱码
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      String mockPath = 'mock/home_data.json';
      String responseString = await rootBundle.loadString(mockPath);
      var result = await jsonDecode(responseString);
      return HomeModel.fromJson(result);
    }
  }
}
