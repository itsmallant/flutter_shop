import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/model/category_list_model.dart';
import 'package:flutter_app/provide/category_list_provide.dart';
import 'package:flutter_app/provide/category_provide.dart';
import 'package:flutter_app/service/service_method.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ChildCategory(),
            ),
            ChangeNotifierProvider(
              create: (context) => CategoryListProvide(),
            )
          ],
          child: Row(
            children: [
              LeftCategoryNav(),
              Column(
                children: [RightCategoryNav(), CategoryGoodsList()],
              )
            ],
          ),
        ));
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
        if (_selectedIndex == index) return;
        setState(() {
          _selectedIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provider.of<ChildCategory>(context, listen: false).setChildCategory(
            context, list[_selectedIndex].mallCategoryId, childList);
      },
      child: Container(
        height: 100.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Color.fromRGBO(236, 236, 236, 1)
                : Colors.white,
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
      Provider.of<ChildCategory>(context, listen: false).setChildCategory(
          context,
          list[_selectedIndex].mallCategoryId,
          list[_selectedIndex].bxMallSubDto);
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
                return _rightInkWell(
                    childCategory.childCategoryList[index], index);
              });
        }));
  }

  Widget _rightInkWell(BxMallSubDto item, int index) {
    bool isSelectedItem =
        Provider.of<ChildCategory>(context, listen: false).selectedIndex ==
            index;
    return InkWell(
      onTap: () {
        Provider.of<ChildCategory>(context, listen: false)
            .setSelectedIndex(context, item.mallSubId, index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: 28.sp,
              color: isSelectedItem ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  EasyRefreshController _controller;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = EasyRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            width: 570.w,
            child: Consumer<CategoryListProvide>(
              builder: (context, value, child) {
                if (Provider.of<ChildCategory>(context, listen: false).page ==
                    1) {
                  try {
                    _controller.resetLoadState();
                    _scrollController.jumpTo(0);
                  } catch (e,s) {
                    //print('error e = $e s = $s');
                  }
                }
                if (value.categoryListItems.length == 0) {
                  return Text('暂时没有数据');
                } else {
                  return EasyRefresh(
                      controller: _controller,
                      footer: ClassicalFooter(
                          enableInfiniteLoad: false,
                          bgColor: Colors.white,
                          textColor: Colors.pink,
                          loadText: "loadText",
                          loadReadyText: "loadReadyText",
                          loadingText: "loadingText",
                          loadedText: "loadedText",
                          loadFailedText: "loadFailedText",
                          noMoreText: "没有更多",
                          showInfo: false),
                      onLoad: () async {
                        Provider.of<ChildCategory>(context, listen: false)
                            .loadMoreGoodsList(context, (size) {
                          if (size > 0) {
                            _controller.finishLoad();
                          } else {
                            _controller.finishLoad(noMore: true);
                            Fluttertoast.showToast(
                                msg: '没有更多数据了',
                                backgroundColor: Colors.pink,
                                textColor: Colors.white);
                          }
                          print('VVOO loadMoreGoodsList size = $size');
                        });
                      },
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: value.categoryListItems.length,
                          itemBuilder: (context, index) {
                            return _listItemWidget(
                                value.categoryListItems[index]);
                          }));
                }
              },
            )));
  }

  Widget _goodsImage(CategoryListItem item) {
    return Container(
      width: 200.w,
      height: 200.h,
      child: Image.network(item.image),
    );
  }

  Widget _goodsName(CategoryListItem item) {
    return Container(
      padding: EdgeInsets.all(5),
      width: 370.w,
      child: Text(
        item.goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 28.sp, color: Colors.black87),
      ),
    );
  }

  Widget _goodsPrice(CategoryListItem item) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
      ),
      width: 370.w,
      child: Row(
        children: [
          Text(
            "价格：￥${item.presentPrice}",
            style: TextStyle(color: Colors.pink, fontSize: 30.sp),
          ),
          Text(
            "￥${item.oriPrice}",
            style: TextStyle(
                decoration: TextDecoration.lineThrough, color: Colors.black26),
          )
        ],
      ),
    );
  }

  Widget _listItemWidget(CategoryListItem item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: [
            _goodsImage(item),
            Column(
              children: [_goodsName(item), _goodsPrice(item)],
            )
          ],
        ),
      ),
    );
  }
}
