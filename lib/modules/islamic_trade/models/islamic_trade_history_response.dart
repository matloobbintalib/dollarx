// To parse this JSON data, do
//
//     final islamicTradeHistoryResponse = islamicTradeHistoryResponseFromJson(jsonString);

import 'dart:convert';

IslamicTradeHistoryResponse islamicTradeHistoryResponseFromJson(dynamic json) => IslamicTradeHistoryResponse.fromJson(json);

String islamicTradeHistoryResponseToJson(IslamicTradeHistoryResponse data) => json.encode(data.toJson());

class IslamicTradeHistoryResponse {
  int status;
  String success;
  String message;
  List<IslamicTradeHistoryModel> data;

  IslamicTradeHistoryResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory IslamicTradeHistoryResponse.fromJson(Map<String, dynamic> json) => IslamicTradeHistoryResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<IslamicTradeHistoryModel>.from(json["data"].map((x) => IslamicTradeHistoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class IslamicTradeHistoryModel {
  int id;
  String userId;
  String amount;
  String currency;
  String currencyRate;
  String copy_trade_item_id;
  String copy_trade_item;
  String totalAmount;
  String profitGain;
  String soldDate;
  String tradeType;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  IslamicTradeHistoryModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.currencyRate,
    required this.copy_trade_item_id,
    required this.copy_trade_item,
    required this.totalAmount,
    required this.profitGain,
    required this.soldDate,
    required this.tradeType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IslamicTradeHistoryModel.fromJson(Map<String, dynamic> json) => IslamicTradeHistoryModel(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    currency: json["currency"],
    currencyRate: json["currency_rate"],
    copy_trade_item_id: json["copy_trade_item_id"],
    copy_trade_item: json["copy_trade_item"],
    totalAmount: json["total_amount"],
    profitGain: json["profit_gain"],
    soldDate: json["sold_date"],
    tradeType: json["trade_type"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "currency": currency,
    "currency_rate": currencyRate,
    "copy_trade_item_id": copy_trade_item_id,
    "copy_trade_item": copy_trade_item,
    "total_amount": totalAmount,
    "profit_gain": profitGain,
    "sold_date": soldDate,
    "trade_type": tradeType,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
