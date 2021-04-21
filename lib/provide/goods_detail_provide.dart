import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/goods_detail_model.dart';
import 'package:flutter_app/service/service_method.dart';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetail goodsDetail;

  void fetchGoodsDetailById(String goodsId) {
    var fromData = {'goodId': goodsId};
    request('getGoodDetailById', formData: fromData).then((val) {
      var responseData = json.decode(val);
      goodsDetail = GoodsDetail.fromJson(responseData);
      notifyListeners();
    });
  }
}
