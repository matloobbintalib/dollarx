import 'package:dio/dio.dart';

class SaveExchangeInput {
  String sell_amount;
  String sell_currency;
  String buy_currency;
  String p2p_type;
  String currency_rate;
  String total_amount;

  SaveExchangeInput({
    required this.sell_amount,
    required this.sell_currency,
    required this.buy_currency,
    required this.p2p_type,
    required this.currency_rate,
    required this.total_amount,
  });

  Map<String, dynamic> toJson() => {
    'sell_amount': sell_amount,
    'sell_currency': sell_currency,
    'buy_currency': buy_currency,
    'p2p_type': p2p_type,
    'currency_rate': currency_rate,
    'total_amount': total_amount,
  };

  FormData toFormData() => FormData.fromMap({
    'sell_amount': sell_amount,
       'sell_currency': sell_currency,
       'buy_currency': buy_currency,
    'p2p_type': p2p_type,
    'currency_rate': currency_rate,
    'total_amount': total_amount,
  });
}
