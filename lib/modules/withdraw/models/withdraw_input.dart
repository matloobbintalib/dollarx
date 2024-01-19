import 'package:dio/dio.dart';

class WithdrawInput {
  final String amount;
  final String currency;
  final String withdraw_type;

  WithdrawInput(
      {required this.amount,
        required this.currency,
        required this.withdraw_type});

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
    "withdraw_type": withdraw_type
  };

  FormData toFormData() => FormData.fromMap({
    'amount': amount,
    'currency': currency,
    'withdraw_type': withdraw_type
  });
}