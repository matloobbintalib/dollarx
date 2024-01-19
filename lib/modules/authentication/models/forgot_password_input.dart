import 'package:dio/dio.dart';

class ForgotPasswordInput {
  final String email;

  ForgotPasswordInput({
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
  };

  FormData toFormData() => FormData.fromMap({
    'email': email,
  });
}