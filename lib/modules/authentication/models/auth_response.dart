// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dollarx/modules/user/models/user_model.dart';

AuthResponse authResponseFromJson(dynamic json) => AuthResponse.fromJson(json);

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  int status;
  String success;
  String message;
  DashboardModel data;
  String token;

  AuthResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: DashboardModel.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
    "token": token,
  };
}

class DashboardModel {
  UserModel user;
  dynamic walletBalanceDollarAx;
  dynamic profitLossDollarAx;
  dynamic totalInvestmentUsdt;
  List<Slider> sliders;
  List<dynamic> topTraders;

  DashboardModel({
    required this.user,
    required this.walletBalanceDollarAx,
    required this.profitLossDollarAx,
    required this.totalInvestmentUsdt,
    required this.sliders,
    required this.topTraders,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
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
