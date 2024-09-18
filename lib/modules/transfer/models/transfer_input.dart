import 'package:dio/dio.dart';

class TransferInput {
  String amount;
  String currency;
  String referral_id;

  TransferInput({
    required this.amount,
    required this.currency,
    required this.referral_id,
  });

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
    "referral_id": referral_id,
  };

  FormData toFormData() => FormData.fromMap({
    "amount": amount,
    "currency": currency,
    "referral_id": referral_id,
  });
}
