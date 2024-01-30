// To parse this JSON data, do
//
//     final withdrawHistoryResponse = withdrawHistoryResponseFromJson(jsonString);

import 'dart:convert';

WithdrawHistoryResponse withdrawHistoryResponseFromJson(dynamic json) => WithdrawHistoryResponse.fromJson(json);

String withdrawHistoryResponseToJson(WithdrawHistoryResponse data) => json.encode(data.toJson());

class WithdrawHistoryResponse {
  int status;
  String success;
  String message;
  List<WithdrawHistoryModel> data;

  WithdrawHistoryResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory WithdrawHistoryResponse.fromJson(Map<String, dynamic> json) => WithdrawHistoryResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<WithdrawHistoryModel>.from(json["data"].map((x) => WithdrawHistoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WithdrawHistoryModel {
  int id;
  String userId;
  String amount;
  String fee;
  String currency;
  String currencyRate;
  String rateId;
  String totalAmount;
  String withdrawType;
  String status;
  dynamic approvedDate;
  dynamic createdAt;
  dynamic updatedAt;

  WithdrawHistoryModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.fee,
    required this.currency,
    required this.currencyRate,
    required this.rateId,
    required this.totalAmount,
    required this.withdrawType,
    required this.status,
    required this.approvedDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WithdrawHistoryModel.fromJson(Map<String, dynamic> json) => WithdrawHistoryModel(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    fee: json["fee"],
    currency: json["currency"],
    currencyRate: json["currency_rate"],
    rateId: json["rate_id"],
    totalAmount: json["total_amount"],
    withdrawType: json["withdraw_type"],
    status: json["status"],
    approvedDate: json["approved_date"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "fee": fee,
    "currency": currency,
    "currency_rate": currencyRate,
    "rate_id": rateId,
    "total_amount": totalAmount,
    "withdraw_type": withdrawType,
    "status": status,
    "approved_date": approvedDate,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
