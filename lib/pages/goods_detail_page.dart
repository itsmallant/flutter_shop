import 'package:flutter/material.dart';
import 'package:flutter_app/provide/goods_detail_provide.dart';
import 'package:flutter_app/routers/application.dart';
import 'package:provider/provider.dart';

class GoodsDetailPage extends StatelessWidget {
  final String goodsId;

  GoodsDetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Application.router.pop(context);
            }),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        future: getGoodsDetailData(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Text("goodId:$goodsId")
              ],
            );
          } else {
            return Text('加载中。。。。');
          }
        },
      ),
    );
  }

  Future getGoodsDetailData(context) async {
    Provider.of<GoodsDetailProvide>(context, listen: false)
        .fetchGoodsDetailById(goodsId);
    return "加载完成";
  }
}
