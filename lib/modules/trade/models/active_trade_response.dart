// To parse this JSON data, do
//
//     final activeTradeResponse = activeTradeResponseFromJson(jsonString);

import 'dart:convert';

ActiveTradeResponse activeTradeResponseFromJson(dynamic json) =>
    ActiveTradeResponse.fromJson(json);

String activeTradeResponseToJson(ActiveTradeResponse data) =>
    json.encode(data.toJson());

class ActiveTradeResponse {
  int status;
  String success;
  String message;
  ActiveTradeData data;

  ActiveTradeResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ActiveTradeResponse.fromJson(Map<String, dynamic> json) =>
      ActiveTradeResponse(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: ActiveTradeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class ActiveTradeData {
  ActiveTrades activeTrades;
  String tradeEffect;
  String profitLossAmount;
  String finalAmount;
  String trade_wallet_balance;

  ActiveTradeData({
    required this.activeTrades,
    required this.tradeEffect,
    required this.profitLossAmount,
    required this.finalAmount,
    required this.trade_wallet_balance,
  });

  factory ActiveTradeData.fromJson(Map<String, dynamic> json) =>
      ActiveTradeData(
        activeTrades: ActiveTrades.fromJson(json["active_trades"]),
        tradeEffect: json["trade_effect"],
        profitLossAmount: json["profitLossAmount"],
        finalAmount: json["final_amount"],
        trade_wallet_balance: json["trade_wallet_balance"],
      );

  Map<String, dynamic> toJson() =>
      {
        "active_trades": activeTrades.toJson(),
        "trade_effect": tradeEffect,
        "profitLossAmount": profitLossAmount,
        "final_amount": finalAmount,
        "trade_wallet_balance": trade_wallet_balance,
      };


  String getProfitLossAmount() {
    if(
    tradeEffect.toString().toLowerCase() == 'loss'){
      return '-${profitLossAmount}';
    }else{
      return '+${profitLossAmount}';
    }
  }
}

class ActiveTrades {
  int id;
  String userId;
  String tradeAmount;
  String totalBarrels;
  String tradeType;
  String tradeStartRateId;
  String initialTradeRate;
  String tradeEndRateId;
  String endTradeRate;
  DateTime tradeStartDateTime;
  dynamic tradeEndDateTime;
  dynamic tradeActiveTime;
  String tradeRateDifference;
  String status;
  String trade_take_profit;
  String trade_stop_loss;
  dynamic tradeFinalEffect;
  dynamic tradeClosingAmount;
  dynamic finalAmount;
  DateTime createdAt;
  DateTime updatedAt;

  ActiveTrades({
    required this.id,
    required this.userId,
    required this.tradeAmount,
    required this.totalBarrels,
    required this.tradeType,
    required this.tradeStartRateId,
    required this.initialTradeRate,
    required this.tradeEndRateId,
    required this.endTradeRate,
    required this.tradeStartDateTime,
    required this.tradeEndDateTime,
    required this.tradeActiveTime,
    required this.tradeRateDifference,
    required this.status,
    required this.trade_take_profit,
    required this.trade_stop_loss,
    required this.tradeFinalEffect,
    required this.tradeClosingAmount,
    required this.finalAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ActiveTrades.fromJson(Map<String, dynamic> json) =>
      ActiveTrades(
        id: json["id"],
        userId: json["user_id"],
        tradeAmount: json["trade_amount"],
        totalBarrels: json["total_barrels"],
        tradeType: json["trade_type"],
        tradeStartRateId: json["trade_start_rate_id"],
        initialTradeRate: json["initial_trade_rate"],
        tradeEndRateId: json["trade_end_rate_id"],
        endTradeRate: json["end_trade_rate"],
        tradeStartDateTime: DateTime.parse(json["trade_start_date_time"]),
        tradeEndDateTime: json["trade_end_date_time"],
        tradeActiveTime: json["trade_active_time"],
        tradeRateDifference: json["trade_rate_difference"],
        status: json["status"],
        trade_take_profit: json["trade_take_profit"],
        trade_stop_loss: json["trade_stop_loss"],
        tradeFinalEffect: json["trade_final_effect"],
        tradeClosingAmount: json["trade_closing_amount"],
        finalAmount: json["final_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "user_id": userId,
        "trade_amount": tradeAmount,
        "total_barrels": totalBarrels,
        "trade_type": tradeType,
        "trade_start_rate_id": tradeStartRateId,
        "initial_trade_rate": initialTradeRate,
        "trade_end_rate_id": tradeEndRateId,
        "end_trade_rate": endTradeRate,
        "trade_start_date_time": tradeStartDateTime.toIso8601String(),
        "trade_end_date_time": tradeEndDateTime,
        "trade_active_time": tradeActiveTime,
        "trade_rate_difference": tradeRateDifference,
        "status": status,
        "trade_take_profit": trade_take_profit,
        "trade_stop_loss": trade_stop_loss,
        "trade_final_effect": tradeFinalEffect,
        "trade_closing_amount": tradeClosingAmount,
        "final_amount": finalAmount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
