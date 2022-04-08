import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:http/http.dart' as http;

var Params = {
  "districtId": -1,
  "groupChannelCode": "RX-OMF",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 0,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {'cid': "09031014111431397988"},
  "contentType": "json"
};

// 旅拍页接口
class TravelDao {
  static Future<TravelItemModel> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    Map paramsMap = Params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    Params['groupChannelCode'] = pageIndex;

    final response = await http.post(url, body: jsonEncode(paramsMap));
    // 使用mock数据
    if (false && response.statusCode == 200) {
      Utf8Decoder utf8Decoder = Utf8Decoder(); // 处理中文乱码
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      return TravelItemModel.fromJson(result);
    } else {
      String mockPath = 'mock/travel_data.json';
      String responseString = await rootBundle.loadString(mockPath);
      var result = await jsonDecode(responseString);
      return TravelItemModel.fromJson(result);
    }
  }
}
