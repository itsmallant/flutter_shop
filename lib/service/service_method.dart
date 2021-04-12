import '../config/service_url.dart';

import 'package:dio/dio.dart';

Future request(String urlName, {formData}) async {
  try {
    print('开始请求数据 urlName = $urlName formData = $formData');
    Dio dio = Dio();
    dio.options.contentType = 'application/x-www-form-urlencoded';
    Response response;
    if (formData == null) {
      response = await dio.post(servicePath[urlName]);
    } else {
      response = await dio.post(servicePath[urlName], data: formData);
    }
    // print('urlName = $urlName 请求到数据 response = $response');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR ---> $e');
  }
}
