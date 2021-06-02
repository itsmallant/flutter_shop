import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  String cartString = '[]';

  void save(goodsId, goodsName, count, price, images) async {
    var prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartString");
    var temp = cartString == null ? [] : json.decode(cartString);
    List<Map> list = (temp as List).cast();

    var isHave = false;
    for (var item in list) {
      if (item['goodsId'] == goodsId) {
        item['count'] += 1;
        isHave = true;
        break;
      }
    }
    if (!isHave) {
      list.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      });
    }
    cartString = json.encode(list).toString();
    print('cartString = $cartString');
    prefs.setString("cartString", cartString);
    notifyListeners();
  }

  void clear() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("cartString");
    print('clear = ==============');
    notifyListeners();
  }
}
