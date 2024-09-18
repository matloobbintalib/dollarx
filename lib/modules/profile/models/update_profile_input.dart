import 'package:dio/dio.dart';

class UpdateProfileInput {
  String? name;
  String? mobile;
  String? city;
  String? address;
  String? postal_code;
  String? gender;
  String? dob;
  MultipartFile? profile_pic;

  UpdateProfileInput({
    this.name,
    this.mobile,
    this.city,
    this.address,
    this.postal_code,
    this.gender,
    this.dob,
    this.profile_pic
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "city": city,
    "address": address,
    "postal_code": postal_code,
    "gender": gender,
    "dob": dob,
    "profile_pic": profile_pic,
  };

  FormData toFormData() => FormData.fromMap({
    "name": name,
    "mobile": mobile,
    "city": city,
    "address": address,
    "postal_code": postal_code,
    "gender": gender,
    "dob": dob,
    "profile_pic": profile_pic,
  });
}
