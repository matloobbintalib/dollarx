// To parse this JSON data, do
//
//     final exchangeRateResponse = exchangeRateResponseFromJson(jsonString);

import 'dart:convert';

ExchangeRateResponse exchangeRateResponseFromJson(dynamic json) => ExchangeRateResponse.fromJson(json);

String exchangeRateResponseToJson(ExchangeRateResponse data) => json.encode(data.toJson());

class ExchangeRateResponse {
  int status;
  String success;
  String message;
  ExchangeRateModel data;

  ExchangeRateResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ExchangeRateResponse.fromJson(Map<String, dynamic> json) => ExchangeRateResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: ExchangeRateModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class ExchangeRateModel {
  String exchangeRate;
  String currenyBalance;
  String crypto_rate;

  ExchangeRateModel({
    required this.exchangeRate,
    required this.currenyBalance,
    required this.crypto_rate,
  });

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) => ExchangeRateModel(
    exchangeRate: json["exchange_rate"],
    currenyBalance: json["curreny_balance"],
    crypto_rate: json["crypto_rate"],
  );

  Map<String, dynamic> toJson() => {
    "exchange_rate": exchangeRate,
    "curreny_balance": currenyBalance,
    "crypto_rate": crypto_rate,
  };
}

