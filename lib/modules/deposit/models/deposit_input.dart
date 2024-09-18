import 'package:dio/dio.dart';

class DepositInput {
  final String amount;
  final String currency;
  final String trans_id;
  final String deposit_data_type;
  MultipartFile? image;

  DepositInput(
      {required this.amount,
        required this.currency,
        required this.trans_id,
        required this.deposit_data_type,
        this.image});

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
    "trans_id": trans_id,
    "trans_type": deposit_data_type,
    "image": image,
  };

  FormData toFormData() => FormData.fromMap({
    'amount': amount,
    'currency': currency,
    'trans_id': trans_id,
    'trans_type': deposit_data_type,
    'image': image,
  });
}