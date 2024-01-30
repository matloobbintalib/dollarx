// To parse this JSON data, do
//
//     final contentPageResponse = contentPageResponseFromJson(jsonString);

import 'dart:convert';

ContentPageResponse contentPageResponseFromJson(json) => ContentPageResponse.fromJson(json);

String contentPageResponseToJson(ContentPageResponse data) => json.encode(data.toJson());

class ContentPageResponse {
  int status;
  String success;
  String message;
  List<ContentPageModel> data;

  ContentPageResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ContentPageResponse.fromJson(Map<String, dynamic> json) => ContentPageResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<ContentPageModel>.from(json["data"].map((x) => ContentPageModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ContentPageModel {
  String title;
  String htmlContent;

  ContentPageModel({
    required this.title,
    required this.htmlContent,
  });

  factory ContentPageModel.fromJson(Map<String, dynamic> json) => ContentPageModel(
    title: json["title"],
    htmlContent: json["html_content"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "html_content": htmlContent,
  };
}
