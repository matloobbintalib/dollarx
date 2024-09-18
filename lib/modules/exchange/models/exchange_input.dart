import 'package:dio/dio.dart';

class ExchangeInput {
  String amount;
  String currency;
  String exchange_type;

  ExchangeInput({
    required this.amount,
    required this.currency,
    required this.exchange_type,
  });

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
    "exchange_type": exchange_type,
  };

  FormData toFormData() => FormData.fromMap({
    "amount": amount,
    "currency": currency,
    "exchange_type": exchange_type,
  });
}
