import 'package:flutter/material.dart';
import 'package:flutter_app/provide/cart_provider.dart';
import 'package:flutter_app/provide/goods_detail_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GoodsDetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provider.of<GoodsDetailProvide>(context,listen: false).goodsDetail.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;
    return Container(
      width: 750.w,
      height: 80.h,
      color: Colors.white,
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              width: 110.w,
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                color: Colors.red,
                size: 20,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Provider.of<CartProvider>(context,listen: false).save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              width: 320.w,
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white, fontSize: 28.sp),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Provider.of<CartProvider>(context,listen: false).clear();
            },
            child: Container(
              alignment: Alignment.center,
              width: 320.w,
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(color: Colors.white, fontSize: 28.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}
