import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];

  @override
  void initState() {
    _fetchHostGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formData = {'lon': 116.44355, 'lat': 39.9219};
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
          future: request('homePageContent', formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var jsonData = json.decode(snapshot.data.toString());
              var data = jsonData['data'];
              List<Map> swiper = (data['slides'] as List).cast();
              List<Map> navigatorList = (data['category'] as List).cast();
              String adPicture = data['advertesPicture']['PICTURE_ADDRESS'];
              String leaderPhone = data['shopInfo']['leaderPhone'];
              String leaderImage = data['shopInfo']['leaderImage'];
              List<Map> recommendList = (data['recommend'] as List).cast();
              String floor1Pic = data['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Pic = data['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Pic = data['floor3Pic']['PICTURE_ADDRESS'];

              List<Map> floor1List = (data['floor1'] as List).cast();
              List<Map> floor2List = (data['floor2'] as List).cast();
              List<Map> floor3List = (data['floor3'] as List).cast();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SwiperDiy(
                      swiperDataList: swiper,
                    ),
                    TopNavigator(
                      navigatorList: navigatorList,
                    ),
                    AdBanner(adPicture),
                    LeaderPhone(leaderImage, leaderPhone),
                    Recommend(recommendList),
                    FloorTitle(floor1Pic),
                    FloorContent(floor1List),
                    FloorTitle(floor2Pic),
                    FloorContent(floor2List),
                    FloorTitle(floor3Pic),
                    FloorContent(floor3List),
                    hotGoods()
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('加载中。。'),
              );
            }
          }),
    );
  }

  void _fetchHostGoodsList() {
    var formData = {'page': 1};
    request('homePageBelowContent', formData).then((val) {
      var jsonData = json.decode(val.toString());
      List<Map> newGoodsList = (jsonData['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  Widget hotGoods() => Container(
        child: Column(
          children: [hotTile, _wrapList()],
        ),
      );

  Widget hotTile = Container(
    margin: EdgeInsets.only(top: 10),
    alignment: Alignment.center,
    color: Colors.transparent,
    padding: EdgeInsets.all(5),
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.isNotEmpty) {
      List<Widget> listWidget = hotGoodsList.map((e) {
        return InkWell(
          child: Container(
              width: 372.w,
              color: Colors.white,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(bottom: 3),
              child: Column(
                children: [
                  Image.network(
                    e['image'],
                    width: 370.w,
                  ),
                  Text(
                    e['name'],
                    style: TextStyle(color: Colors.pink, fontSize: 24.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "￥${e['mallPrice']}",
                      ),
                      Text(
                        "￥${e['price']}",
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  )
                ],
              )),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(
    //     BoxConstraints(
    //         maxWidth: MediaQuery.of(context).size.width,
    //         maxHeight: MediaQuery.of(context).size.height),
    //     designSize: Size(750, 1334));
    return Container(
      height: 333.h,
      width: 750.w,
      child: Swiper(
        itemCount: swiperDataList.length,
        itemBuilder: (context, index) {
          return Image.network(
            '${swiperDataList[index]['image']}',
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: [
          Image.network(
            item['image'],
            width: 95.w,
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(
        10,
        navigatorList.length,
      );
    }

    return Container(
      height: 340.h,
      padding: EdgeInsets.all(3),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner(this.adPicture, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

class LeaderPhone extends StatelessWidget {
  final String leaderPhone;
  final String leaderImage;

  LeaderPhone(this.leaderImage, this.leaderPhone, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchUrl,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchUrl() async {
    String url = 'tel:$leaderPhone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url 不能进行访问异常';
    }
  }
}

class Recommend extends StatelessWidget {
  final List _recommendList;

  Recommend(this._recommendList, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380.h,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [_titleWidget(), _recommendListView()],
      ),
    );
  }

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12))),
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 330.w,
        width: 250.h,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(right: BorderSide(color: Colors.black12))),
        child: Column(
          children: [
            Image.network(_recommendList[index]['image']),
            Text('￥${_recommendList[index]['mallPrice']}'),
            Text(
              '￥${_recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommendListView() {
    return Container(
      height: 330.h,
      child: ListView.builder(
        itemCount: _recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class FloorTitle extends StatelessWidget {
  final String floorPicAddress;

  const FloorTitle(this.floorPicAddress, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Image.network(floorPicAddress),
    );
  }
}

class FloorContent extends StatelessWidget {
  final List _floorContentList;

  const FloorContent(this._floorContentList, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_topGoodsRow(), _bottomGoodsColumn()],
      ),
    );
  }

  Widget _topGoodsRow() => Row(
        children: [
          _goodItem(_floorContentList[0]),
          Column(
            children: [
              _goodItem(_floorContentList[1]),
              _goodItem(_floorContentList[2]),
            ],
          )
        ],
      );

  Widget _bottomGoodsColumn() => Row(
        children: [
          _goodItem(_floorContentList[3]),
          _goodItem(_floorContentList[4]),
        ],
      );

  Widget _goodItem(Map goods) {
    return Container(
      width: 375.w,
      child: InkWell(
        onTap: () {
          print('楼层商品被点击了');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
