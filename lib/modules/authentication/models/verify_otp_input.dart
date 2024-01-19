import 'package:dio/dio.dart';

class VerifyOtpInput {
  final String email;
  final String otp;

  VerifyOtpInput({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "otp": otp,
  };

  FormData toFormData() => FormData.fromMap({
    'email': email,
    'otp': otp,
  });
}