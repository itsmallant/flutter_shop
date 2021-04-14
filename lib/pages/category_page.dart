import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/provide/category_provide.dart';
import 'package:flutter_app/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Row(
        children: [
          LeftCategoryNav(),
          Column(
            children: [RightCategoryNav()],
          )
        ],
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<Data> list = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.black12, width: 1))),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
        itemCount: list.length,
      ),
    );
  }

  Widget _leftInkWell(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provider.of<ChildCategory>(context, listen: false)
            .setChildCategory(childList);
      },
      child: Container(
        height: 100.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _selectedIndex == index ? Color.fromRGBO(236, 236, 236, 1) : Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        child: Text(list[index].mallCategoryName),
      ),
    );
  }

  void _getCategory() async {
    request('getCategory').then((value) {
      var data = json.decode(value.toString());
      var categoryModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryModel.data;
      });
      Provider.of<ChildCategory>(context, listen: false)
          .setChildCategory(list[_selectedIndex].bxMallSubDto);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  //List<String> list = ['太白', '陕西西风', '贵州茅台', '老白干', '五粮液', '二锅头'];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.h,
        width: 570.w,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black26)),
        ),
        child:
            Consumer<ChildCategory>(builder: (context, childCategory, child) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index) {
                return _rightInkWell(childCategory.childCategoryList[index]);
              });
        }));
  }

  Widget _rightInkWell(BxMallSubDto item) {
    return InkWell(
      onTap: () {
        print('11');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: 28.sp),
        ),
      ),
    );
  }
}
