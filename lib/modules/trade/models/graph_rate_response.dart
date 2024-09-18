// To parse this JSON data, do
//
//     final graphRatesResponse = graphRatesResponseFromJson(jsonString);

import 'dart:convert';

GraphRatesResponse graphRatesResponseFromJson(dynamic json) => GraphRatesResponse.fromJson(json);

String graphRatesResponseToJson(GraphRatesResponse data) => json.encode(data.toJson());

class GraphRatesResponse {
  int status;
  String success;
  String message;
  List<BtcGraphModel> data;

  GraphRatesResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory GraphRatesResponse.fromJson(Map<String, dynamic> json) => GraphRatesResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<BtcGraphModel>.from(json["data"].map((x) => BtcGraphModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BtcGraphModel {
  int id;
  BaseCurrency baseCurrency;
  Symbol symbol;
  Unit unit;
  String openRate;
  String highRate;
  String lowRate;
  String closeRate;
  dynamic timeStamp;
  String time;
  dynamic date;
  DateTime createdAt;
  DateTime updatedAt;

  BtcGraphModel({
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
    required this.updatedAt,
  });

  factory BtcGraphModel.fromJson(Map<String, dynamic> json) => BtcGraphModel(
    id: json["id"],
    baseCurrency: baseCurrencyValues.map[json["base_currency"]]!,
    symbol: symbolValues.map[json["symbol"]]!,
    unit: unitValues.map[json["unit"]]!,
    openRate: json["open_rate"],
    highRate: json["high_rate"],
    lowRate: json["low_rate"],
    closeRate: json["close_rate"],
    timeStamp: json["time_stamp"],
    time: json["time"],
    date: json["date"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "base_currency": baseCurrencyValues.reverse[baseCurrency],
    "symbol": symbolValues.reverse[symbol],
    "unit": unitValues.reverse[unit],
    "open_rate": openRate,
    "high_rate": highRate,
    "low_rate": lowRate,
    "close_rate": closeRate,
    "time_stamp": timeStamp,
    "time": time,
    "date": date,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

enum BaseCurrency {
  USD
}

final baseCurrencyValues = EnumValues({
  "USD": BaseCurrency.USD
});

enum Symbol {
  BTC
}

final symbolValues = EnumValues({
  "BTC": Symbol.BTC
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
