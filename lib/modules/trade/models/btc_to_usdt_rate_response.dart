// To parse this JSON data, do
//
//     final btcToUsdtRateResponse = btcToUsdtRateResponseFromJson(jsonString);

import 'dart:convert';

BtcToUsdtRateResponse btcToUsdtRateResponseFromJson(dynamic json) => BtcToUsdtRateResponse.fromJson(json);

String btcToUsdtRateResponseToJson(BtcToUsdtRateResponse data) => json.encode(data.toJson());

class BtcToUsdtRateResponse {
  String symbol;
  String price;

  BtcToUsdtRateResponse({
    required this.symbol,
    required this.price,
  });

  factory BtcToUsdtRateResponse.fromJson(Map<String, dynamic> json) => BtcToUsdtRateResponse(
    symbol: json["symbol"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
    "price": price,
  };
}
