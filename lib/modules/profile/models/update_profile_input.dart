import 'package:dio/dio.dart';

class UpdateProfileInput {
  String? name;
  String? mobile;
  String? city;
  String? address;
  MultipartFile? profile_pic;

  UpdateProfileInput({
    this.name,
    this.mobile,
    this.city,
    this.address,
    this.profile_pic
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "city": city,
    "address": address,
    "profile_pic": profile_pic,
  };

  FormData toFormData() => FormData.fromMap({
    "name": name,
    "mobile": mobile,
    "city": city,
    "address": address,
    "profile_pic": profile_pic,
  });
}
