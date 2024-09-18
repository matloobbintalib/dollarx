// To parse this JSON data, do
//
//     final p2PExchangeHistoryResponse = p2PExchangeHistoryResponseFromJson(jsonString);

import 'dart:async';
import 'dart:convert';

P2PExchangeHistoryResponse p2PExchangeHistoryResponseFromJson(dynamic json) => P2PExchangeHistoryResponse.fromJson(json);

String p2PExchangeHistoryResponseToJson(P2PExchangeHistoryResponse data) => json.encode(data.toJson());

class P2PExchangeHistoryResponse {
  int status;
  String success;
  String message;
  List<P2PExchangeModel> data;

  P2PExchangeHistoryResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory P2PExchangeHistoryResponse.fromJson(Map<String, dynamic> json) => P2PExchangeHistoryResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<P2PExchangeModel>.from(json["data"].map((x) => P2PExchangeModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class P2PExchangeModel {
  int id;
  String userId;
  String user_type;
  String sellAmount;
  String sellCurrency;
  String currencyRate;
  String buyCurrency;
  String buyAmount;
  String fee;
  String totalAmount;
  dynamic walletAddress;
  String accountNo;
  String accountName;
  String bankName;
  dynamic branchCode;
  String ibanNo;
  dynamic exchangeDate;
  String? buyerId;
  String p2PType;
  dynamic profImage;
  String exchangeStatus;
  String status;
  String? user_referral_id;
  String? buyer_referral_id;
  DateTime createdAt;
  DateTime updatedAt;

  P2PExchangeModel({
    required this.id,
    required this.userId,
    required this.user_type,
    required this.sellAmount,
    required this.sellCurrency,
    required this.currencyRate,
    required this.buyCurrency,
    required this.buyAmount,
    required this.fee,
    required this.totalAmount,
    required this.walletAddress,
    required this.accountNo,
    required this.accountName,
    required this.bankName,
    required this.branchCode,
    required this.ibanNo,
    required this.exchangeDate,
    required this.buyerId,
    required this.p2PType,
    required this.profImage,
    required this.exchangeStatus,
    required this.status,
    required this.user_referral_id,
    required this.buyer_referral_id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory P2PExchangeModel.fromJson(Map<String, dynamic> json) => P2PExchangeModel(
    id: json["id"],
    userId: json["user_id"],
    user_type: json["user_type"],
    sellAmount: json["sell_amount"],
    sellCurrency: json["sell_currency"],
    currencyRate: json["currency_rate"],
    buyCurrency: json["buy_currency"],
    buyAmount: json["buy_amount"],
    fee: json["fee"],
    totalAmount: json["total_amount"],
    walletAddress: json["wallet_address"]??'',
    accountNo: json["account_no"]??'',
    accountName: json["account_name"]??'',
    bankName: json["bank_name"]??'',
    branchCode: json["branch_code"]??'',
    ibanNo: json["iban_no"]??'',
    exchangeDate: json["exchange_date"]??'',
    buyerId: json["buyer_id"]??'',
    p2PType: json["p2p_type"]??'',
    profImage: json["prof_image"],
    exchangeStatus: json["exchange_status"],
    status: json["status"],
    user_referral_id: json["user_referral_id"]??'',
    buyer_referral_id: json["user_referral_id"]??'',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "user_type": user_type,
    "sell_amount": sellAmount,
    "sell_currency": sellCurrency,
    "currency_rate": currencyRate,
    "buy_currency": buyCurrency,
    "buy_amount": buyAmount,
    "fee": fee,
    "total_amount": totalAmount,
    "wallet_address": walletAddress,
    "account_no": accountNo,
    "account_name": accountName,
    "bank_name": bankName,
    "branch_code": branchCode,
    "iban_no": ibanNo,
    "exchange_date": exchangeDate,
    "buyer_id": buyerId,
    "p2p_type": p2PType,
    "prof_image": profImage,
    "exchange_status": exchangeStatus,
    "status": status,
    "user_referral_id": user_referral_id,
    "buyer_referral_id": buyer_referral_id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
