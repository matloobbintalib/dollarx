import 'package:dio/dio.dart';

class KycVerificationInput {
  final String kyc_doc_type;
  final String country;
  MultipartFile? cnic_front;
  MultipartFile? cnic_back;
  MultipartFile? upload_document;

  KycVerificationInput({
    required this.kyc_doc_type,
    required this.country,
    this.cnic_front,
    this.cnic_back,
    this.upload_document
  });

  Map<String, dynamic> toJson() => {
    "kyc_doc_type": kyc_doc_type,
    "country": country,
    "cnic_front": cnic_front,
    "cnic_back": cnic_back,
    // "upload_document": upload_document,
  };

  FormData toFormData() => FormData.fromMap({
    "kyc_doc_type": kyc_doc_type,
    "country": country,
    "cnic_front": cnic_front,
    "cnic_back": cnic_back,
    // "upload_document": upload_document,
  });
}
