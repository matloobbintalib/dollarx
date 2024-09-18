// To parse this JSON data, do
//
//     final countryListResponse = countryListResponseFromJson(jsonString);

import 'dart:convert';

CountryListResponse countryListResponseFromJson(dynamic json) => CountryListResponse.fromJson(json);

String countryListResponseToJson(CountryListResponse data) => json.encode(data.toJson());

class CountryListResponse {
  int status;
  String success;
  String message;
  List<CountryModel> data;

  CountryListResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory CountryListResponse.fromJson(Map<String, dynamic> json) => CountryListResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<CountryModel>.from(json["data"].map((x) => CountryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CountryModel {
  String name;
  String currency;

  CountryModel({
    required this.name,
    required this.currency,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    name: json["name"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "currency": currency,
  };
}
