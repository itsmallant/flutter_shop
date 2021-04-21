import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/provide/goods_detail_provide.dart';
import 'package:flutter_app/routers/application.dart';
import 'package:flutter_app/routers/routers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import './pages/index_page.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FluroRouter router = new FluroRouter();
    Routes.configRoutes(router);
    Application.router = router;

    return ScreenUtilInit(
        designSize: Size(750, 1334),
        allowFontScaling: false,
        builder: () => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) {
                  return GoodsDetailProvide();
                })
              ],
              child: _createAppWidget(),
            ));
  }

  Widget _createAppWidget() => MaterialApp(
        onGenerateRoute: Application.router.generator,
        title: "百姓生活+",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      );
}
