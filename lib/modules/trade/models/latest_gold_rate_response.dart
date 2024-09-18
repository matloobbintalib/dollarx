// To parse this JSON data, do
//
//     final latestGoldRateResponse = latestGoldRateResponseFromJson(jsonString);

import 'dart:convert';

GoldLatestRateResponse goldLatestRateResponseFromJson(dynamic json) => GoldLatestRateResponse.fromJson(json);

String goldLatestRateResponseToJson(GoldLatestRateResponse data) => json.encode(data.toJson());

class GoldLatestRateResponse {
  int status;
  String success;
  String message;
  GoldLatestRateModel data;

  GoldLatestRateResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory GoldLatestRateResponse.fromJson(Map<String, dynamic> json) => GoldLatestRateResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: GoldLatestRateModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class GoldLatestRateModel {
  String tradeRate;

  GoldLatestRateModel({
    required this.tradeRate,
  });

  factory GoldLatestRateModel.fromJson(Map<String, dynamic> json) => GoldLatestRateModel(
    tradeRate: json["trade_rate"],
  );

  Map<String, dynamic> toJson() => {
    "trade_rate": tradeRate,
  };
}
