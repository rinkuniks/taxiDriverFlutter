// class ApiBaseResponse {
//   Response? response;
//
//   ApiBaseResponse({this.response});
//
//   ApiBaseResponse.fromJson(Map<String, dynamic> json) {
//     response = json['response'] != null
//         ? new Response.fromJson(json['response'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.response != null) {
//       data['response'] = this.response!.toJson();
//     }
//     return data;
//   }
// }

class ApiBaseResponse<T> {
  String? message;
  T? data;
  int? code;

  ApiBaseResponse({this.message, this.data, this.code});

  ApiBaseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}
