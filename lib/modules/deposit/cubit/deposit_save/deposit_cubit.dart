

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dollarx/modules/authentication/models/base_response.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../../../../../core/exceptions/api_error.dart';
import '../../models/deposit_input.dart';
import '../../repo/deposit_repository.dart';
import 'deposit_state.dart';


class DepositCubit extends Cubit<DepositState> {
  DepositCubit(this._lotRepository) : super(DepositState.Initial());

  final DepositRepository _lotRepository;

  Future<void> depositSave(DepositInput depositInput, File? file) async {
    MultipartFile? image ;
    emit(state.copyWith(depositStatus: DepositStatus.loading));
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
            depositInput.image = image;
          } else {
            emit(state.copyWith(
                depositStatus: DepositStatus.error,
                message: "Image should be less than 2MB"));
            return;
          }
        }
      }
      BaseResponse baseResponse = await _lotRepository.depositSave(depositInput);
      if (baseResponse.status == 200) {
        emit(state.copyWith(depositStatus: DepositStatus.success, message: baseResponse.message));
      } else {
        emit(state.copyWith(
            depositStatus: DepositStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          depositStatus: DepositStatus.error, message: e.message));
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
