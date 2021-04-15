import 'package:flutter/material.dart';
import 'package:flutter_app/model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  int selectedIndex = 0;

  setChildCategory(List<BxMallSubDto> list) {
    selectedIndex = 0;
    BxMallSubDto bxMallSubDto = BxMallSubDto(
        mallCategoryId: '00',
        mallSubId: '00',
        mallSubName: '全部',
        comments: 'null');
    childCategoryList = [bxMallSubDto];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
