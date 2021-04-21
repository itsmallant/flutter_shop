import 'package:flutter/material.dart';
import 'package:flutter_app/provide/goods_detail_provide.dart';
import 'package:provider/provider.dart';

class GoodsDetailPage extends StatelessWidget {
  final String goodsId;

  GoodsDetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {

    Provider.of<GoodsDetailProvide>(context,listen: false).fetchGoodsDetailById(goodsId);
    return Container(
      child: Text("Goods Id:$goodsId"),
    );

  }
}
