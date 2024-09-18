// To parse this JSON data, do
//
//     final countriesListResponse = countriesListResponseFromJson(jsonString);

import 'dart:convert';

CountriesListResponse countriesListResponseFromJson(dynamic json) => CountriesListResponse.fromJson(json);

String countriesListResponseToJson(CountriesListResponse data) => json.encode(data.toJson());

class CountriesListResponse {
  int status;
  String success;
  String message;
  List<CountryListModel> data;

  CountriesListResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory CountriesListResponse.fromJson(Map<String, dynamic> json) => CountriesListResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<CountryListModel>.from(json["data"].map((x) => CountryListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CountryListModel {
  String name;
  String currency;

  CountryListModel({
    required this.name,
    required this.currency,
  });

  factory CountryListModel.fromJson(Map<String, dynamic> json) => CountryListModel(
    name: json["name"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "currency": currency,
  };
}
