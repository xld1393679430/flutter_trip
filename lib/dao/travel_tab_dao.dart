import 'dart:async';
import 'dart:convert';

import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;

const URL = 'http://www.devio.org/io/flutter_app/json/travel_page.json';

// 旅拍类别接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8Decoder = Utf8Decoder(); // 处理中文乱码
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    }
    throw Exception('TravelTabDao error');
  }
}
