// To parse this JSON data, do
//
//     final depositDataResponse = depositDataResponseFromJson(jsonString);

import 'dart:convert';

DepositDataResponse depositDataResponseFromJson(dynamic json) => DepositDataResponse.fromJson(json);

String depositDataResponseToJson(DepositDataResponse data) => json.encode(data.toJson());

class DepositDataResponse {
  int status;
  String success;
  String message;
  DepositModel data;

  DepositDataResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory DepositDataResponse.fromJson(Map<String, dynamic> json) => DepositDataResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: DepositModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class DepositModel {
  int usdtDepositsBalance;
  int btcDepositsBalance;
  int ethDepositsBalance;
  List<InvestmentCurrency> investmentCurrencies;

  DepositModel({
    required this.usdtDepositsBalance,
    required this.btcDepositsBalance,
    required this.ethDepositsBalance,
    required this.investmentCurrencies,
  });

  factory DepositModel.fromJson(Map<String, dynamic> json) => DepositModel(
    usdtDepositsBalance: json["USDTDepositsBalance"],
    btcDepositsBalance: json["BTCDepositsBalance"],
    ethDepositsBalance: json["ETHDepositsBalance"],
    investmentCurrencies: List<InvestmentCurrency>.from(json["investment_currencies"].map((x) => InvestmentCurrency.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "USDTDepositsBalance": usdtDepositsBalance,
    "BTCDepositsBalance": btcDepositsBalance,
    "ETHDepositsBalance": ethDepositsBalance,
    "investment_currencies": List<dynamic>.from(investmentCurrencies.map((x) => x.toJson())),
  };
}

class InvestmentCurrency {
  String name;
  String symbol;
  String adminAddress;
  String image;

  InvestmentCurrency({
    required this.name,
    required this.symbol,
    required this.adminAddress,
    required this.image,
  });

  factory InvestmentCurrency.fromJson(Map<String, dynamic> json) => InvestmentCurrency(
    name: json["name"],
    symbol: json["symbol"],
    adminAddress: json["admin_address"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "symbol": symbol,
    "admin_address": adminAddress,
    "image": image,
  };
}
