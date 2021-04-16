import 'package:flutter/material.dart';
import 'package:flutter_app/model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  int selectedIndex = 0;
  String categoryId = '4';
  String subId = '';

  setChildCategory(String categoryId, List<BxMallSubDto> list) {
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
  }

  void setSelectedIndex(String subId, int index) {
    this.subId = subId;
    selectedIndex = index;
    notifyListeners();
  }
}
