import 'package:dio/dio.dart';

class TradeTPSLInput {
  String trade_take_profit;
  String? trade_stop_loss;

  TradeTPSLInput({
    required this.trade_take_profit,
    required this.trade_stop_loss,
  });

  Map<String, dynamic> toJson() => {
    "trade_take_profit": trade_take_profit,
    "trade_stop_loss": trade_stop_loss,
  };

  FormData toFormData() => FormData.fromMap({
    "trade_take_profit": trade_take_profit,
    "trade_stop_loss": trade_stop_loss,
  });
}
