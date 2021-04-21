import 'package:fluro/fluro.dart';
import 'package:flutter_app/routers/router_handler.dart';

class Routes {
  static String ROOT = "/";
  static String GOODS_DETAIL_PAGE = "/detail";

  static configRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (context, paramters) {
      print('Route not found params = $paramters');
    });

    router.define(GOODS_DETAIL_PAGE, handler: goodsDetailHandler);
  }
}
