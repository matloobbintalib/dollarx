// To parse this JSON data, do
//
//     final dashboardDataResponse = dashboardDataResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dollarx/modules/user/models/user_model.dart';

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
  int balance;
  String profitBalance;
  String bonusBalance;
  String totalReferralInvestment;
  List<Slider> sliders;

  DashboardDataModel({
    required this.user,
    required this.balance,
    required this.profitBalance,
    required this.bonusBalance,
    required this.totalReferralInvestment,
    required this.sliders,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) => DashboardDataModel(
    user: UserModel.fromJson(json["user"]),
    balance: json["balance"],
    profitBalance: json["profit_balance"],
    bonusBalance: json["bonus_balance"],
    totalReferralInvestment: json["totalReferralInvestment"],
    sliders: List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "balance": balance,
    "profit_balance": profitBalance,
    "bonus_balance": bonusBalance,
    "totalReferralInvestment": totalReferralInvestment,
    "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
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
