import 'package:dio/dio.dart';

class ResetPasswordInput {
  final String email;
  final String password;
  final String confirm_password;

  ResetPasswordInput({
    required this.email,
    required this.password,
    required this.confirm_password,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "confirm_password": 'confirm_password',
  };

  FormData toFormData() => FormData.fromMap({
    'email': email,
    'password': password,
    'confirm_password': confirm_password,
  });
}