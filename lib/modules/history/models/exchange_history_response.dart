// To parse this JSON data, do
//
//     final exchangeHistoryResponse = exchangeHistoryResponseFromJson(jsonString);

import 'dart:convert';

ExchangeHistoryResponse exchangeHistoryResponseFromJson(dynamic json) => ExchangeHistoryResponse.fromJson(json);

String exchangeHistoryResponseToJson(ExchangeHistoryResponse data) => json.encode(data.toJson());

class ExchangeHistoryResponse {
  int status;
  String success;
  String message;
  List<ExchangeHistoryModel> data;

  ExchangeHistoryResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ExchangeHistoryResponse.fromJson(Map<String, dynamic> json) => ExchangeHistoryResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<ExchangeHistoryModel>.from(json["data"].map((x) => ExchangeHistoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ExchangeHistoryModel {
  int id;
  String userId;
  String amount;
  String currency;
  String fundReceiverId;
  String fundReceiverReferralId;
  String descriptions;
  DateTime createdAt;
  DateTime updatedAt;

  ExchangeHistoryModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.fundReceiverId,
    required this.fundReceiverReferralId,
    required this.descriptions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExchangeHistoryModel.fromJson(Map<String, dynamic> json) => ExchangeHistoryModel(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    currency: json["currency"],
    fundReceiverId: json["fund_receiver_id"],
    fundReceiverReferralId: json["fund_receiver_referral_id"],
    descriptions: json["descriptions"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "currency": currency,
    "fund_receiver_id": fundReceiverId,
    "fund_receiver_referral_id": fundReceiverReferralId,
    "descriptions": descriptions,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
