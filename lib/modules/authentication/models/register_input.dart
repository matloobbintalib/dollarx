import 'package:dio/dio.dart';

class RegisterInput {
  final String name;
  final String email;
  final String password;
  final String parent_id;
  final String mobile;
  final String password_confirmation;
  String? fcmToken;

  RegisterInput({
    required this.name,
    required this.email,
    required this.password,
    required this.parent_id,
    required this.mobile,
    required this.password_confirmation,
    this.fcmToken = "",
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "parent_id": parent_id,
        "mobile": mobile,
        "password_confirmation": password_confirmation,
        "fcm_token": fcmToken,
      };

  FormData toFormData() => FormData.fromMap({
        "name": name,
        "email": email,
        "password": password,
        "parent_id": parent_id,
        "mobile": mobile,
        "password_confirmation": password_confirmation,
        "fcm_token": fcmToken,
      });
}
