// To parse this JSON data, do
//
//     final btcToUsdtGraphResponse = btcToUsdtGraphResponseFromJson(jsonString);

import 'dart:convert';

BtcToUsdtGraphResponse btcToUsdtGraphResponseFromJson(String str) => BtcToUsdtGraphResponse.fromJson(json.decode(str));

String btcToUsdtGraphResponseToJson(BtcToUsdtGraphResponse data) => json.encode(data.toJson());

class BtcToUsdtGraphResponse {
  int status;
  String success;
  String message;
  List<BtcToUsdtGraph> data;

  BtcToUsdtGraphResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory BtcToUsdtGraphResponse.fromJson(Map<String, dynamic> json) => BtcToUsdtGraphResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<BtcToUsdtGraph>.from(json["data"].map((x) => BtcToUsdtGraph.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BtcToUsdtGraph {
  int openTime;
  String openPrice;
  String highPrice;
  String lowPrice;
  String closePrice;
  String volume;
  int closeTime;
  String quoteAssetVolume;
  int numberOfTrades;

  BtcToUsdtGraph({
    required this.openTime,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.closePrice,
    required this.volume,
    required this.closeTime,
    required this.quoteAssetVolume,
    required this.numberOfTrades,
  });

  factory BtcToUsdtGraph.fromJson(Map<String, dynamic> json) => BtcToUsdtGraph(
    openTime: json["Open_Time"],
    openPrice: json["Open_Price"],
    highPrice: json["High_Price"],
    lowPrice: json["Low_Price"],
    closePrice: json["Close_Price"],
    volume: json["Volume"],
    closeTime: json["Close_Time"],
    quoteAssetVolume: json["Quote_Asset_Volume"],
    numberOfTrades: json["Number_of_Trades"],
  );

  Map<String, dynamic> toJson() => {
    "Open_Time": openTime,
    "Open_Price": openPrice,
    "High_Price": highPrice,
    "Low_Price": lowPrice,
    "Close_Price": closePrice,
    "Volume": volume,
    "Close_Time": closeTime,
    "Quote_Asset_Volume": quoteAssetVolume,
    "Number_of_Trades": numberOfTrades,
  };
}
