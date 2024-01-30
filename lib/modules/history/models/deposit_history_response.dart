// To parse this JSON data, do
//
//     final depositHistoryResponse = depositHistoryResponseFromJson(jsonString);

import 'dart:convert';

DepositHistoryResponse depositHistoryResponseFromJson(dynamic json) => DepositHistoryResponse.fromJson(json);

String depositHistoryResponseToJson(DepositHistoryResponse data) => json.encode(data.toJson());

class DepositHistoryResponse {
  int status;
  String success;
  String message;
  List<DepositHistoryModel> data;

  DepositHistoryResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory DepositHistoryResponse.fromJson(Map<String, dynamic> json) => DepositHistoryResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<DepositHistoryModel>.from(json["data"].map((x) => DepositHistoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DepositHistoryModel {
  int id;
  String userId;
  String amount;
  String currency;
  String currencyRate;
  String rateId;
  String totalAmount;
  String transactionId;
  String transactionDate;
  String proofImage;
  String planId;
  String depositType;
  String status;
  String createdAt;
  String updatedAt;

  DepositHistoryModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.currencyRate,
    required this.rateId,
    required this.totalAmount,
    required this.transactionId,
    required this.transactionDate,
    required this.proofImage,
    required this.planId,
    required this.depositType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DepositHistoryModel.fromJson(Map<String, dynamic> json) => DepositHistoryModel(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    currency: json["currency"],
    currencyRate: json["currency_rate"],
    rateId: json["rate_id"],
    totalAmount: json["total_amount"],
    transactionId: json["transaction_id"],
    transactionDate: json["transaction_date"],
    proofImage: json["proof_image"],
    planId: json["plan_id"],
    depositType: json["deposit_type"],
    status: json["status"],
    createdAt:json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "currency": currency,
    "currency_rate": currencyRate,
    "rate_id": rateId,
    "total_amount": totalAmount,
    "transaction_id": transactionId,
    "transaction_date": transactionDate,
    "proof_image": proofImage,
    "plan_id": planId,
    "deposit_type": depositType,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
