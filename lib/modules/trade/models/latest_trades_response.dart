// To parse this JSON data, do
//
//     final latestTradesResponse = latestTradesResponseFromJson(jsonString);

import 'dart:convert';

LatestTradesResponse latestTradesResponseFromJson(String str) => LatestTradesResponse.fromJson(json.decode(str));

String latestTradesResponseToJson(LatestTradesResponse data) => json.encode(data.toJson());

class LatestTradesResponse {
  int status;
  String success;
  String message;
  LatestTradeModel data;

  LatestTradesResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory LatestTradesResponse.fromJson(Map<String, dynamic> json) => LatestTradesResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: LatestTradeModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class LatestTradeModel {
  dynamic btcCurrentRate;
  String tradeBalance;
  List<Trade> buyTrades;
  List<Trade> sellTrades;

  LatestTradeModel({
    required this.btcCurrentRate,
    required this.tradeBalance,
    required this.buyTrades,
    required this.sellTrades,
  });

  factory LatestTradeModel.fromJson(Map<String, dynamic> json) => LatestTradeModel(
    btcCurrentRate: json["btc_current_rate"],
    tradeBalance: json["trade_balance"],
    buyTrades: List<Trade>.from(json["buy_trades"].map((x) => Trade.fromJson(x))),
    sellTrades: List<Trade>.from(json["sell_trades"].map((x) => Trade.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "btc_current_rate": btcCurrentRate,
    "trade_balance": tradeBalance,
    "buy_trades": List<dynamic>.from(buyTrades.map((x) => x.toJson())),
    "sell_trades": List<dynamic>.from(sellTrades.map((x) => x.toJson())),
  };
}

class Trade {
  Status status;
  TradeFinalEffect tradeFinalEffect;
  dynamic tradeClosingAmount;
  String tradeClosingAmountUsd;
  String tradeCloseBtcRate;
  String finalAmount;

  Trade({
    required this.status,
    required this.tradeFinalEffect,
    required this.tradeClosingAmount,
    required this.tradeClosingAmountUsd,
    required this.tradeCloseBtcRate,
    required this.finalAmount,
  });

  factory Trade.fromJson(Map<String, dynamic> json) => Trade(
    status: statusValues.map[json["status"]]!,
    tradeFinalEffect: tradeFinalEffectValues.map[json["trade_final_effect"]]!,
    tradeClosingAmount: json["trade_closing_amount"],
    tradeClosingAmountUsd: json["trade_closing_amount_usd"],
    tradeCloseBtcRate: json["trade_close_btc_rate"],
    finalAmount: json["final_amount"],
  );

  Map<String, dynamic> toJson() => {
    "status": statusValues.reverse[status],
    "trade_final_effect": tradeFinalEffectValues.reverse[tradeFinalEffect],
    "trade_closing_amount": tradeClosingAmount,
    "trade_closing_amount_usd": tradeClosingAmountUsd,
    "trade_close_btc_rate": tradeCloseBtcRate,
    "final_amount": finalAmount,
  };
}

enum Status {
  COMPLETED
}

final statusValues = EnumValues({
  "Completed": Status.COMPLETED
});

enum TradeFinalEffect {
  LOSS,
  PROFIT
}

final tradeFinalEffectValues = EnumValues({
  "Loss": TradeFinalEffect.LOSS,
  "Profit": TradeFinalEffect.PROFIT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
