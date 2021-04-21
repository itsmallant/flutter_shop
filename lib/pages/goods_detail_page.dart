import 'package:flutter/material.dart';

class GoodsDetailPage extends StatelessWidget {
  String goodsId;
  
  GoodsDetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Goods Id:$goodsId"),
    );
  }
}
