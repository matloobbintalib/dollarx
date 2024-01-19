import 'package:dio/dio.dart';

class LoginInput {
  final String email;
  final String password;

  LoginInput({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "fcm_token": 'fcmToken',
      };

  FormData toFormData() => FormData.fromMap({
        'email': email,
        'password': password,
        'fcm_token': 'fcmToken',
      });
}