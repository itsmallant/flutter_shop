import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: [
          Container(
            height: 500,
            child:   ListView.builder(
                itemCount: testList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(testList[index]),
                  );
                }),
          ),

          RaisedButton(
            onPressed: () {
              _add();
            },
            child: Text("add"),
          ),
          RaisedButton(
            onPressed: () {
              _clear();
            },
            child: Text("clear"),
          )
        ],
      ),
    );
  }

  List<String> testList = [];

  _add() async {
    var prefs = await SharedPreferences.getInstance();
    var temp = 'you are kind!';
    testList.add(temp);
    prefs.setStringList("testInfo", testList);
    _show();
  }

  _show() async {
    var prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList("testInfo");
    if (list != null) {
      setState(() {
        testList = list;
      });
    }
  }

  _clear() async {
    var prefs = await SharedPreferences.getInstance();
    var remove = prefs.remove("testInfo");
    setState(() {
      testList = [];
    });
  }
}
