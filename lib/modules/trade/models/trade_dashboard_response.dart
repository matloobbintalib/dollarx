// To parse this JSON data, do
//
//     final tradeDashboardResponse = tradeDashboardResponseFromJson(jsonString);

import 'dart:convert';

TradeDashboardResponse tradeDashboardResponseFromJson(dynamic json) => TradeDashboardResponse.fromJson(json);

String tradeDashboardResponseToJson(TradeDashboardResponse data) => json.encode(data.toJson());

class TradeDashboardResponse {
  int status;
  String success;
  String message;
  TradeDataModel data;

  TradeDashboardResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory TradeDashboardResponse.fromJson(Map<String, dynamic> json) => TradeDashboardResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: TradeDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class TradeDataModel {
  List<CurrencyDatum> currencyData;
  String totalBalanceUsd;
  String daxBalance;
  String yesterdayBuyProfitLoss;
  String yesterdaySellProfitLoss;

  TradeDataModel({
    required this.currencyData,
    required this.totalBalanceUsd,
    required this.daxBalance,
    required this.yesterdayBuyProfitLoss,
    required this.yesterdaySellProfitLoss,
  });

  factory TradeDataModel.fromJson(Map<String, dynamic> json) => TradeDataModel(
    currencyData: List<CurrencyDatum>.from(json["currency_data"].map((x) => CurrencyDatum.fromJson(x))),
    totalBalanceUsd: json["total_balance_usd"],
    daxBalance: json["dax_balance"],
    yesterdayBuyProfitLoss: json["YesterdayBuyProfitLoss"],
    yesterdaySellProfitLoss: json["YesterdaySellProfitLoss"],
  );

  Map<String, dynamic> toJson() => {
    "currency_data": List<dynamic>.from(currencyData.map((x) => x.toJson())),
    "total_balance_usd": totalBalanceUsd,
    "dax_balance": daxBalance,
    "YesterdayBuyProfitLoss": yesterdayBuyProfitLoss,
    "YesterdaySellProfitLoss": yesterdaySellProfitLoss,
  };
}

class CurrencyDatum {
  String currency;
  double balance;
  dynamic rate;
  double balanceUsd;

  CurrencyDatum({
    required this.currency,
    required this.balance,
    required this.rate,
    required this.balanceUsd,
  });

  factory CurrencyDatum.fromJson(Map<String, dynamic> json) => CurrencyDatum(
    currency: json["currency"],
    balance: json["balance"]?.toDouble(),
    rate: json["rate"],
    balanceUsd: json["balance_usd"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "balance": balance,
    "rate": rate,
    "balance_usd": balanceUsd,
  };
}
