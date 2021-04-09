import '../config/service_url.dart';

import 'package:dio/dio.dart';

Future request(String urlName,var formData)async{
  try {
    print('开始请求数据');
    Dio dio = Dio();
    dio.options.contentType = 'application/x-www-form-urlencoded';
    Response response =
        await dio.post(servicePath[urlName], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR ---> $e');
  }
}
