import 'package:flutter/material.dart';
import 'package:flutter_app/provide/goods_detail_provide.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsDetailWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GoodsDetailProvide>(builder: (context, val, child) {
      if (val.isLeft) {
        return Html(data: val.goodsDetail.data.goodInfo.goodsDetail);
      } else {
        return Container(
          width: 750.w,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text('暂时没有数据'),
        );
      }
    });
    return Container();
  }
}
