import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/model/category_list_model.dart';
import 'package:flutter_app/service/service_method.dart';
import 'package:provider/provider.dart';

import 'category_list_provide.dart';

typedef OnLoadCallback = void Function(int);

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  int selectedIndex = 0;
  String categoryId = '4';
  String subId = '';
  int page;
  bool isHasMore = true;

  setChildCategory(
      BuildContext context, String categoryId, List<BxMallSubDto> list) {
    page = 1;
    isHasMore = true;
    selectedIndex = 0;
    this.categoryId = categoryId;
    subId = '';
    BxMallSubDto bxMallSubDto = BxMallSubDto(
        mallCategoryId: categoryId,
        mallSubId: '',
        mallSubName: '全部',
        comments: 'null');
    childCategoryList = [bxMallSubDto];
    childCategoryList.addAll(list);
    notifyListeners();
    getGoodsList(context);
  }

  void setSelectedIndex(BuildContext context, String subId, int index) {
    page = 1;
    isHasMore = true;
    this.subId = subId;
    selectedIndex = index;
    notifyListeners();
    getGoodsList(context);
  }

  void getGoodsList(BuildContext context) {
    var data = {'categoryId': categoryId, 'categorySubId': subId, 'page': page};
    request('getMallGoods', formData: data).then((val) {
      var decodeData = json.decode(val.toString());
      var categoryListModel = CategoryListModel.fromJson(decodeData);
      Provider.of<CategoryListProvide>(context, listen: false)
          .setCategoryListItems(
              categoryListModel.data == null ? [] : categoryListModel.data);
    });
  }

  void loadMoreGoodsList(
      BuildContext context, void Function(int size) callback) {
    page++;
    var data = {'categoryId': categoryId, 'categorySubId': subId, 'page': page};
    request('getMallGoods', formData: data).then((val) {
      var decodeData = json.decode(val.toString());
      var categoryListModel = CategoryListModel.fromJson(decodeData);
      var newList = categoryListModel.data == null
          ? <CategoryListItem>[]
          : categoryListModel.data;
      Provider.of<CategoryListProvide>(context, listen: false)
          .addCategoryListItems(newList);
      callback(newList.length);
      if(newList.length == 0){
        isHasMore = false;
      }
    });
  }
}
