import 'package:dio/dio.dart';

class BuySellInput {
  String amount;
  String? limit_value;
  String? limit_btcrate;
  String? trade_take_profit;
  String? trade_stop_loss;

  BuySellInput({
    required this.amount,
    this.limit_value,
    this.limit_btcrate,
    this.trade_take_profit,
    this.trade_stop_loss,
  });

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "limit_value": limit_value,
    "limit_btcrate": limit_btcrate,
    "trade_take_profit": trade_take_profit,
    "trade_stop_loss": trade_stop_loss,
  };

  FormData toFormData() => FormData.fromMap({
    "amount": amount,
    "limit_value": limit_value,
    "limit_btcrate": limit_btcrate,
    "trade_take_profit": trade_take_profit,
    "trade_stop_loss": trade_stop_loss,
  });
}
