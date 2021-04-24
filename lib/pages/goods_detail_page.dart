import 'package:flutter/material.dart';
import 'package:flutter_app/pages/goods_detail/goods_detail_bottom.dart';
import 'package:flutter_app/pages/goods_detail/goods_detail_explain.dart';
import 'package:flutter_app/pages/goods_detail/goods_detail_tabbar.dart';
import 'package:flutter_app/pages/goods_detail/goods_detail_top_area.dart';
import 'package:flutter_app/pages/goods_detail/goods_detail_web.dart';
import 'package:flutter_app/provide/goods_detail_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            return Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 80.h),
                  child: ListView(
                    children: [
                      GoodsDetailTopArea(),
                      GoodsDetailExplain(),
                      GoodsDetailTabBar(),
                      GoodsDetailWeb()
                    ],
                  ),
                ),
                Positioned(
                  child: GoodsDetailBottom(),
                  bottom: 0,
                  left: 0,
                )
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
    await Provider.of<GoodsDetailProvide>(context, listen: false)
        .fetchGoodsDetailById(goodsId);
    return "加载完成";
  }
}
