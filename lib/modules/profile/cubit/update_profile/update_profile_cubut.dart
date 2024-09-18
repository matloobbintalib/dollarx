import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dollarax/modules/profile/cubit/update_profile/update_profile_state.dart';
import '../../../../core/exceptions/api_error.dart';
import '../../../authentication/models/auth_response.dart';
import '../../../authentication/models/base_response.dart';
import '../../models/update_profile_input.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../repo/profile_repository.dart';


class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this._repository) : super(UpdateProfileState.initial());

  final ProfileRepository _repository;

  Future updateProfile(UpdateProfileInput updateProfileInput,File? file) async {
    MultipartFile? image ;
    emit(state.copyWith(updateProfileStatus: UpdateProfileStatus.loading));
    try {
      if (file != null) {
        XFile? compressedImage = await compressImage(file.path);
        if (compressedImage != null) {
          // Get the file size in bytes
          int fileSizeInBytes = File(compressedImage.path).lengthSync();

          // Convert bytes to megabytes (MB)
          double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
          print('size in mb :: $fileSizeInMB');

          // Check if the compressed image is less than 2MB
          if (fileSizeInMB < 2) {
            print(compressedImage.path);
            image = await MultipartFile.fromFile(
              compressedImage.path,
              filename: compressedImage.name,
            );
            updateProfileInput.profile_pic = image;
          } else {
            emit(state.copyWith(
                updateProfileStatus: UpdateProfileStatus.failure,
                message: "Image should be less than 2MB"));
            return;
          }
        }
      }
      BaseResponse baseResponse = await _repository.updateProfile(updateProfileInput);
      if (baseResponse.status == 200) {
        emit(state.copyWith(
            updateProfileStatus: UpdateProfileStatus.success,
            message: baseResponse.message));
      } else {
        emit(state.copyWith(
            updateProfileStatus: UpdateProfileStatus.failure,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          updateProfileStatus: UpdateProfileStatus.failure, message: e.message));
    } catch (_) {}
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
