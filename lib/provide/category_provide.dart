import 'package:flutter/material.dart';
import 'package:flutter_app/model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  setChildCategory(List<BxMallSubDto> list) {
    BxMallSubDto bxMallSubDto = BxMallSubDto(mallCategoryId: '00',mallSubId: '00',mallSubName: '全部',comments: 'null');
    childCategoryList.add(bxMallSubDto);
    childCategoryList.addAll(list);
    notifyListeners();
  }

}