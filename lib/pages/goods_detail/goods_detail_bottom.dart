import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsDetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            onTap: () {},
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
            onTap: () {},
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
