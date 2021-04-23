import 'package:flutter/material.dart';
import 'package:flutter_app/provide/goods_detail_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GoodsDetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<GoodsDetailProvide>(
          builder: (context, goodsDetailProvide, child) {
        var goodsInfo = goodsDetailProvide.goodsDetail.data.goodInfo;
        if (goodsInfo == null) {
          return Text("加载中。。");
        } else {
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _goodsImage(String url) {
    return Image.network(
      url,
      width: 740.w,
    );
  }

  Widget _goodsName(String name) {
    return Container(
      width: 740.w,
      padding: EdgeInsets.only(left: 15),
      child: Text(
        name,
        style: TextStyle(fontSize: 30.sp),
      ),
    );
  }

  Widget _goodsNum(String num) {
    return Container(
      width: 730.w,
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号：$num',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  Widget _goodsPrice(presentPrice, originPrice) {
    return Container(
        width: 730.w,
        padding: EdgeInsets.only(left: 15),
        margin: EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Container(
              child: Text(
                '￥$presentPrice',
                style: TextStyle(color: Colors.pink, fontSize: 30.sp),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '市场价：',
                style: TextStyle(
                  color: Colors.black12,
                ),
              ),
            ),
            Container(
              child: Text(
                '￥$originPrice',
                style: TextStyle(
                    color: Colors.black12,
                    decoration: TextDecoration.lineThrough),
              ),
            )
          ],
        ));
  }
}
