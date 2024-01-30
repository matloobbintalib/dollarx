// To parse this JSON data, do
//
//     final profitHistoryResponse = profitHistoryResponseFromJson(jsonString);

import 'dart:convert';

ProfitHistoryResponse profitHistoryResponseFromJson(dynamic json) => ProfitHistoryResponse.fromJson(json);

String profitHistoryResponseToJson(ProfitHistoryResponse data) => json.encode(data.toJson());

class ProfitHistoryResponse {
  int status;
  String success;
  String message;
  List<ProfitHistoryModel> data;

  ProfitHistoryResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProfitHistoryResponse.fromJson(Map<String, dynamic> json) => ProfitHistoryResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<ProfitHistoryModel>.from(json["data"].map((x) => ProfitHistoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProfitHistoryModel {
  int id;
  String userId;
  String amount;
  String total;
  String currency;
  String type;
  String description;
  dynamic createdAt;
  dynamic updatedAt;

  ProfitHistoryModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.total,
    required this.currency,
    required this.type,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfitHistoryModel.fromJson(Map<String, dynamic> json) => ProfitHistoryModel(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    total: json["total"],
    currency: json["currency"],
    type: json["type"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "total": total,
    "currency": currency,
    "type": type,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
