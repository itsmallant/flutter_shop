// class Response<T extends Data>{
//   String code;
//   String message;
//   T data;
//
//   Response({this.code, this.message, this.data});
//
//   Response.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     message = json['message'];
//     (T?.runtimeType as Data).;
//     data = json['data'] != null ? T.(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     return data;
//   }
// }
//
// abstract class Data{
//   Map<String, dynamic> toJson();
//
// }