// To parse this JSON data, do
//
//     final forgotPasswordResponse = forgotPasswordResponseFromJson(jsonString);

import 'dart:convert';

BaseResponse baseResponseFromJson(dynamic json) => BaseResponse.fromJson(json);

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  int status;
  String success;
  String message;

  BaseResponse({
    required this.status,
    required this.success,
    required this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
  };
}
