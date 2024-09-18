import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/bank_account/cubit/add_bank_info_state.dart';
import 'package:dollarax/modules/bank_account/models/bank_info_input.dart';
import 'package:dollarax/modules/bank_account/repo/bank_info_repository.dart';
import 'package:dollarax/modules/kyc_verification/cubit/kyc_verification/kyc_verification_state.dart';
import 'package:dollarax/modules/kyc_verification/models/kyc_verification_input.dart';
import 'package:dollarax/modules/kyc_verification/repo/kyc_verification_repository.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../../../../../core/exceptions/api_error.dart';


class KycVerificationCubit extends Cubit<KycVerificationState> {
  KycVerificationCubit(this._repository) : super(KycVerificationState.Initial());

  final KycVerificationRepository _repository;

  Future<void> addKycVerification(KycVerificationInput kycVerificationInput, File? frontIdImage,File? backIdImage) async {
    MultipartFile? backImage ;
    MultipartFile? frontImage ;
    emit(state.copyWith(kycVerificationStatus: KycVerificationStatus.loading));
    try {

      if (frontIdImage != null) {
        XFile? compressedImage = await compressImage(frontIdImage.path);
        if (compressedImage != null) {
          // Get the file size in bytes
          int fileSizeInBytes = File(compressedImage.path).lengthSync();

          // Convert bytes to megabytes (MB)
          double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
          print('size in mb :: $fileSizeInMB');

          // Check if the compressed image is less than 2MB
          if (fileSizeInMB < 2) {
            print(compressedImage.path);
            frontImage = await MultipartFile.fromFile(
              compressedImage.path,
              filename: compressedImage.name,
            );
            kycVerificationInput.cnic_front = frontImage;
          } else {
            emit(state.copyWith(
                kycVerificationStatus: KycVerificationStatus.error,
                message: "Image should be less than 2MB"));
            return;
          }
        }
      }

      if (backIdImage != null) {
        XFile? compressedImage = await compressImage(backIdImage.path);
        if (compressedImage != null) {
          // Get the file size in bytes
          int fileSizeInBytes = File(compressedImage.path).lengthSync();

          // Convert bytes to megabytes (MB)
          double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
          print('size in mb :: $fileSizeInMB');

          // Check if the compressed image is less than 2MB
          if (fileSizeInMB < 2) {
            print(compressedImage.path);
            backImage = await MultipartFile.fromFile(
              compressedImage.path,
              filename: compressedImage.name,
            );
            kycVerificationInput.cnic_back = backImage;
          } else {
            emit(state.copyWith(
                kycVerificationStatus: KycVerificationStatus.error,
                message: "Image should be less than 2MB"));
            return;
          }
        }
      }

      BaseResponse baseResponse = await _repository.kycVerification(kycVerificationInput);
      if (baseResponse.status == 200) {
        emit(state.copyWith(kycVerificationStatus: KycVerificationStatus.success, message: baseResponse.message));
      } else {
        emit(state.copyWith(
            kycVerificationStatus: KycVerificationStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          kycVerificationStatus: KycVerificationStatus.error, message: e.message));
    }
  }

  Future<XFile?> compressImage(String imagePath) async {
    try {
      // Compress the image
      XFile? compressedImage = await FlutterImageCompress.compressAndGetFile(
        imagePath,
        imagePath.endsWith('.png')
            ? imagePath.replaceAll('.png', '_compressed.jpg')
            : imagePath.replaceAll('.jpg', '_compressed.jpg'),
        minWidth: 1024,
        minHeight: 1024,
        quality: 85,
      );
      return compressedImage;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
