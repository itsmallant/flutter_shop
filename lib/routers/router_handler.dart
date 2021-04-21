
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/goods_detail_page.dart';

Handler goodsDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
  String goodsId = parameters['id'].first;
  print('goodsDetailHandler goodsId = $goodsId');
  return GoodsDetailPage(goodsId);
});