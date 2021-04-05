import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/pages/cart_page.dart';
import 'package:flutter_app/pages/category_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '首页'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: '分类'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), label: '购物车'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: '会员中心'),
  ];

  int _currentIndex = 0;

  Widget _currentPage;

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  void initState() {
    _currentPage = tabBodies[_currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        items: bottomTabs,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _currentPage = tabBodies[index];
          });
        },
      ),
      body: _currentPage,
    );
  }
}
