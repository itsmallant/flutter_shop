import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var typeController = TextEditingController();
  var showText = '欢迎来到美好人间';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('美好人间'),
        ),
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  labelText: '美女类型',
                  helperText: '请输入你喜欢的美女类型',
                ),
                autofocus: false,
              ),
              RaisedButton(
                onPressed: _choiceAction,
                child: Text('选择完毕'),
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _choiceAction() {
    print('开始选择');
    if (typeController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('美女类型不能为空'),
            );
          });
    } else {
      getHttp(typeController.text.toString()).then((value) {
        setState(() {
          showText = '${value['data']['namecn']} 欢迎你！';
        });
      });
    }
  }

  Future getHttp(String cityId) async {
    try {
      Established
      var data = {
        'type':'cityid',
        'id': cityId};
      var response = await Dio().get(
          'http://www.weatherol.cn/api/getCityInfo',
          queryParameters: data);
      print('response = $response');
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
