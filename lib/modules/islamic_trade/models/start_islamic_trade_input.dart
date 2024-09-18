import 'package:dio/dio.dart';

class StartIslamicTradeInput {
  String amount;
  String currency;
  String trade_type;
  int item_id;

  StartIslamicTradeInput({
    required this.amount,
    required this.currency,
    required this.trade_type,
    required this.item_id,
  });

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
    "trade_type": trade_type,
    "item_id": item_id,
  };

  FormData toFormData() => FormData.fromMap({
    "amount": amount,
    "currency": currency,
    "trade_type": trade_type,
    "item_id": item_id,
  });
}
