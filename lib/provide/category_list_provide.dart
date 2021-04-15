import 'package:flutter/material.dart';
import 'package:flutter_app/model/category_list_model.dart';

class CategoryListProvide with ChangeNotifier {
  List<CategoryListItem> categoryListItems = [];

  setCategoryListItems(List<CategoryListItem> list) {
    categoryListItems = list;
    notifyListeners();
  }
}
