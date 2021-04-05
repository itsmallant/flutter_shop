import '../config/service_url.dart';

import 'package:dio/dio.dart';

Future getHomePageContent() async {
  try {
    print('开始请求首页数据');
    Dio dio = Dio();
    dio.options.contentType = 'application/x-www-form-urlencoded';

    var formData = {'lon': 116.44355, 'lat': 39.9219};
    Response response =
        await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR ---> $e');
  }
}
