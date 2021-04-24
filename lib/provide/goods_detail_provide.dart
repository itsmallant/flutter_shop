import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/goods_detail_model.dart';
import 'package:flutter_app/service/service_method.dart';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetail goodsDetail;

  bool isLeft = true;
  bool isRight = false;

  void changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  Future fetchGoodsDetailById(String goodsId) {
    var fromData = {'goodId': goodsId};
    return request('getGoodDetailById', formData: fromData).then((val) {
      var responseData = json.decode(val);
      goodsDetail = GoodsDetail.fromJson(responseData);
      notifyListeners();
    });
  }
}
