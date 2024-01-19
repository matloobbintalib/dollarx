import 'package:dio/dio.dart';

class DepositInput {
  final String amount;
  final String currency;
  final String trans_id;
  MultipartFile? image;

  DepositInput(
      {required this.amount,
        required this.currency,
        required this.trans_id,
        this.image});

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
    "trans_id": trans_id,
    "image": image,
  };

  FormData toFormData() => FormData.fromMap({
    'amount': amount,
    'currency': currency,
    'trans_id': trans_id,
    'image': image,
  });
}