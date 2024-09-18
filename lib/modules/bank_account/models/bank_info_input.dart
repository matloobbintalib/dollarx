import 'package:dio/dio.dart';

class BankInfoInput {
  final String bank_name;
  final String bank_account_name;
  final String bank_iban_no;
  final String btc_address;
  final String eth_address;
  final String usdt_address;
  final String country;

  BankInfoInput(
      {required this.bank_name,
        required this.bank_account_name,
        required this.bank_iban_no,
        required this.btc_address,
        required this.eth_address,
        required this.usdt_address,
        required this.country,
      });

  Map<String, dynamic> toJson() => {
    "bank_name": bank_name,
    "bank_account_name": bank_account_name,
    "bank_iban_no": bank_iban_no,
    "btc_address": btc_address,
    "eth_address": eth_address,
    "usdt_address": usdt_address,
    "country": country,
  };

  FormData toFormData() => FormData.fromMap({
    "bank_name": bank_name,
    "bank_account_name": bank_account_name,
    "bank_iban_no": bank_iban_no,
    "btc_address": btc_address,
    "eth_address": eth_address,
    "usdt_address": usdt_address,
    "country": country,
  });
}