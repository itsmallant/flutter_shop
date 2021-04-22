import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsDetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: C,
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
        '编号：$num'
      ),
    );
  }
}
