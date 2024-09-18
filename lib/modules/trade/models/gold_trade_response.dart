// To parse this JSON data, do
//
//     final goldTradeResponse = goldTradeResponseFromJson(jsonString);

import 'dart:convert';

GoldTradeResponse goldTradeResponseFromJson(dynamic json) => GoldTradeResponse.fromJson(json);

String goldTradeResponseToJson(GoldTradeResponse data) => json.encode(data.toJson());

class GoldTradeResponse {
  int status;
  String success;
  String message;
  List<GoldTradeModel> data;

  GoldTradeResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory GoldTradeResponse.fromJson(Map<String, dynamic> json) => GoldTradeResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<GoldTradeModel>.from(json["data"].map((x) => GoldTradeModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GoldTradeModel {
  int id;
  String baseCurrency;
  String symbol;
  Unit unit;
  double openRate;
  double highRate;
  double lowRate;
  double closeRate;
  DateTime timeStamp;
  dynamic time;
  DateTime date;
  DateTime createdAt;

  GoldTradeModel({
    required this.id,
    required this.baseCurrency,
    required this.symbol,
    required this.unit,
    required this.openRate,
    required this.highRate,
    required this.lowRate,
    required this.closeRate,
    required this.timeStamp,
    required this.time,
    required this.date,
    required this.createdAt,
  });

  factory GoldTradeModel.fromJson(Map<String, dynamic> json) => GoldTradeModel(
    id: json["id"],
    baseCurrency: json["base_currency"]!,
    symbol: json["symbol"]!,
    unit: unitValues.map[json["unit"]]!,
    openRate: json["open_rate"].toDouble(),
    highRate: json["high_rate"].toDouble(),
    lowRate: json["low_rate"].toDouble(),
    closeRate: json["close_rate"].toDouble(),
    timeStamp: DateTime.parse(json["time_stamp"]),
    time: json["time"],
    date: DateTime.parse(json["date"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "base_currency": baseCurrency,
    "symbol": symbolValues.reverse[symbol],
    "unit": unitValues.reverse[unit],
    "open_rate": openRate,
    "high_rate": highRate,
    "low_rate": lowRate,
    "close_rate": closeRate,
    "time_stamp": timeStamp.toIso8601String(),
    "time": time,
    "date": date.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}

enum BaseCurrency {
  USDT
}

final baseCurrencyValues = EnumValues({
  "USDT": BaseCurrency.USDT
});

enum Symbol {
  XAUUSD
}

final symbolValues = EnumValues({
  "xauusd": Symbol.XAUUSD
});

enum Unit {
  COIN
}

final unitValues = EnumValues({
  "coin": Unit.COIN
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
