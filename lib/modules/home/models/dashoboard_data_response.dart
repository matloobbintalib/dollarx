// To parse this JSON data, do
//
//     final dashboardDataResponse = dashboardDataResponseFromJson(jsonString);

import 'dart:convert';

import '../../user/models/user_model.dart';

DashboardDataResponse dashboardDataResponseFromJson(dynamic json) => DashboardDataResponse.fromJson(json);

String dashboardDataResponseToJson(DashboardDataResponse data) => json.encode(data.toJson());

class DashboardDataResponse {
  int status;
  String success;
  String message;
  DashboardDataModel data;

  DashboardDataResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory DashboardDataResponse.fromJson(Map<String, dynamic> json) => DashboardDataResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: DashboardDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class DashboardDataModel {
  UserModel user;
  dynamic walletBalanceDollarAx;
  dynamic profitLossDollarAx;
  dynamic totalInvestmentUsdt;
  List<Slider> sliders;
  List<dynamic> topTraders;

  DashboardDataModel({
    required this.user,
    required this.walletBalanceDollarAx,
    required this.profitLossDollarAx,
    required this.totalInvestmentUsdt,
    required this.sliders,
    required this.topTraders,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) => DashboardDataModel(
    user: UserModel.fromJson(json["user"]),
    walletBalanceDollarAx: json["walletBalanceDollarAx"],
    profitLossDollarAx: json["profitLossDollarAx"],
    totalInvestmentUsdt: json["totalInvestmentUSDT"],
    sliders: List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
    topTraders: List<dynamic>.from(json["topTraders"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "walletBalanceDollarAx": walletBalanceDollarAx,
    "profitLossDollarAx": profitLossDollarAx,
    "totalInvestmentUSDT": totalInvestmentUsdt,
    "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
    "topTraders": List<dynamic>.from(topTraders.map((x) => x)),
  };
}

class Slider {
  String title;
  String image;

  Slider({
    required this.title,
    required this.image,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
  };
}
