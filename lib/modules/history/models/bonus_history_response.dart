// To parse this JSON data, do
//
//     final bonusHistoryResponse = bonusHistoryResponseFromJson(jsonString);

import 'dart:convert';

BonusHistoryResponse bonusHistoryResponseFromJson(dynamic json) => BonusHistoryResponse.fromJson(json);

String bonusHistoryResponseToJson(BonusHistoryResponse data) => json.encode(data.toJson());

class BonusHistoryResponse {
  int status;
  String success;
  String message;
  List<BonusHistoryModel> data;

  BonusHistoryResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory BonusHistoryResponse.fromJson(Map<String, dynamic> json) => BonusHistoryResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<BonusHistoryModel>.from(json["data"].map((x) => BonusHistoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BonusHistoryModel {
  int id;
  String userId;
  dynamic amount;
  dynamic type;
  dynamic level;
  dynamic depositId;
  dynamic description;
  dynamic createdAt;
  dynamic updatedAt;

  BonusHistoryModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.level,
    required this.depositId,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BonusHistoryModel.fromJson(Map<String, dynamic> json) => BonusHistoryModel(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    type: json["type"],
    level: json["level"],
    depositId: json["deposit_id"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "type": type,
    "level": level,
    "deposit_id": depositId,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
