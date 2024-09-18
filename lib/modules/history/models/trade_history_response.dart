// To parse this JSON data, do
//
//     final tradeHistoryResponse = tradeHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dollarax/modules/trade/models/active_trade_response.dart';

TradeHistoryResponse tradeHistoryResponseFromJson(dynamic json) => TradeHistoryResponse.fromJson(json);

String tradeHistoryResponseToJson(TradeHistoryResponse data) => json.encode(data.toJson());

class TradeHistoryResponse {
  int status;
  String success;
  String message;
  List<ActiveTrades> data;

  TradeHistoryResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory TradeHistoryResponse.fromJson(Map<String, dynamic> json) => TradeHistoryResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<ActiveTrades>.from(json["data"].map((x) => ActiveTrades.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
