import 'package:flutter/material.dart';
import 'package:flutter_app/provide/goods_detail_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GoodsDetailTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Consumer<GoodsDetailProvide>(builder: (context,val,child){
        return Row(
          children: [
            myLeftTabbar(context,val.isLeft),
            myRightTabbar(context,val.isRight)
          ],
        );
      }),
    );
  }

  Widget myLeftTabbar(context, isLeft) {
    return InkWell(
      onTap: (){
        Provider.of<GoodsDetailProvide>(context,listen: false).changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: 375.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    color: isLeft ? Colors.pink : Colors.black12, width: 1))),
        child: Text(
          '详情',
          style: TextStyle(color: isLeft ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  Widget myRightTabbar(context, isRight) {
    return InkWell(
      onTap: (){
        Provider.of<GoodsDetailProvide>(context,listen: false).changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: 375.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    color: isRight ? Colors.pink : Colors.black12, width: 1))),
        child: Text(
          '评论',
          style: TextStyle(color: isRight ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}
