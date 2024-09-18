// To parse this JSON data, do
//
//     final tradeProfitLossGraphResponse = tradeProfitLossGraphResponseFromJson(jsonString);

import 'dart:convert';

TradeProfitLossGraphResponse tradeProfitLossGraphResponseFromJson(dynamic json) => TradeProfitLossGraphResponse.fromJson(json);

String tradeProfitLossGraphResponseToJson(TradeProfitLossGraphResponse data) => json.encode(data.toJson());

class TradeProfitLossGraphResponse {
  int status;
  String success;
  String message;
  TradeProfitLossGraphModel data;

  TradeProfitLossGraphResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory TradeProfitLossGraphResponse.fromJson(Map<String, dynamic> json) => TradeProfitLossGraphResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: TradeProfitLossGraphModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class TradeProfitLossGraphModel {
  List<GraphTrade> graphBuyTrades;
  List<GraphTrade> graphSellTrades;

  TradeProfitLossGraphModel({
    required this.graphBuyTrades,
    required this.graphSellTrades,
  });

  factory TradeProfitLossGraphModel.fromJson(Map<String, dynamic> json) => TradeProfitLossGraphModel(
    graphBuyTrades: List<GraphTrade>.from(json["graph_buy_trades"].map((x) => GraphTrade.fromJson(x))),
    graphSellTrades: List<GraphTrade>.from(json["graph_sell_trades"].map((x) => GraphTrade.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "graph_buy_trades": List<dynamic>.from(graphBuyTrades.map((x) => x.toJson())),
    "graph_sell_trades": List<dynamic>.from(graphSellTrades.map((x) => x.toJson())),
  };
}

class GraphTrade {
  int id;
  String userId;
  String tradeAmount;
  String totalBarrels;
  String tradeType;
  String tradeStartRateId;
  String tradeEndRateId;
  DateTime tradeStartDateTime;
  DateTime tradeEndDateTime;
  dynamic tradeActiveTime;
  String tradeRateDifference;
  String status;
  String tradeFinalEffect;
  String tradeClosingAmount;
  String tradeCloseBtcRate;
  String finalAmount;
  DateTime createdAt;
  DateTime updatedAt;

  GraphTrade({
    required this.id,
    required this.userId,
    required this.tradeAmount,
    required this.totalBarrels,
    required this.tradeType,
    required this.tradeStartRateId,
    required this.tradeEndRateId,
    required this.tradeStartDateTime,
    required this.tradeEndDateTime,
    required this.tradeActiveTime,
    required this.tradeRateDifference,
    required this.status,
    required this.tradeFinalEffect,
    required this.tradeClosingAmount,
    required this.tradeCloseBtcRate,
    required this.finalAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GraphTrade.fromJson(Map<String, dynamic> json) => GraphTrade(
    id: json["id"],
    userId: json["user_id"],
    tradeAmount: json["trade_amount"],
    totalBarrels: json["total_barrels"],
    tradeType: json["trade_type"],
    tradeStartRateId: json["trade_start_rate_id"],
    tradeEndRateId: json["trade_end_rate_id"],
    tradeStartDateTime: DateTime.parse(json["trade_start_date_time"]),
    tradeEndDateTime: DateTime.parse(json["trade_end_date_time"]),
    tradeActiveTime: json["trade_active_time"],
    tradeRateDifference: json["trade_rate_difference"],
    status: json["status"],
    tradeFinalEffect: json["trade_final_effect"],
    tradeClosingAmount: json["trade_closing_amount"],
    tradeCloseBtcRate: json["trade_close_btc_rate"],
    finalAmount: json["final_amount"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "trade_amount": tradeAmount,
    "total_barrels": totalBarrels,
    "trade_type": tradeType,
    "trade_start_rate_id": tradeStartRateId,
    "trade_end_rate_id": tradeEndRateId,
    "trade_start_date_time": tradeStartDateTime.toIso8601String(),
    "trade_end_date_time": tradeEndDateTime.toIso8601String(),
    "trade_active_time": tradeActiveTime,
    "trade_rate_difference": tradeRateDifference,
    "status": status,
    "trade_final_effect": tradeFinalEffect,
    "trade_closing_amount": tradeClosingAmount,
    "trade_close_btc_rate": tradeCloseBtcRate,
    "final_amount": finalAmount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
