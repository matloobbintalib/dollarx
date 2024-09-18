import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_rates/exchange_rates_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/hold_exchange/hold_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/proof_upload/proof_upload_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/save_exchange/save_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/exchange_rate_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_proof_upload_input.dart';
import 'package:dollarax/modules/p2p_exchange/models/save_exchange_input.dart';
import 'package:dollarax/modules/p2p_exchange/repo/p2p_repository.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../../../../core/exceptions/api_error.dart';

class ProofUploadCubit extends Cubit<ProofUploadState> {
  final P2PRepository _repository;

  ProofUploadCubit(this._repository) : super(ProofUploadState.Initial());


  Future<void> p2pSellProofUpload(P2pProofUploadInput input,File? file) async {
    MultipartFile? image ;
    emit(state.copyWith(proofUploadStatus: ProofUploadStatus.loading));
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
            input.prof_image = image;
          } else {
            emit(state.copyWith(
                proofUploadStatus: ProofUploadStatus.error,
                message: "Image should be less than 2MB"));
            return;
          }
        }
      }
      BaseResponse response = await _repository.p2pSellProofUpload(input);
      if (response.status == 200) {
        emit(state.copyWith(
            proofUploadStatus: ProofUploadStatus.success,
            message: response.message));
      } else {
        emit(state.copyWith(
            proofUploadStatus: ProofUploadStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          proofUploadStatus: ProofUploadStatus.error, message: e.message));
    }
  }

  Future<void> p2pBuyProofUpload(P2pProofUploadInput input,File? file) async {
    MultipartFile? image ;
    emit(state.copyWith(proofUploadStatus: ProofUploadStatus.loading));
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
            input.prof_image = image;
          } else {
            emit(state.copyWith(
                proofUploadStatus: ProofUploadStatus.error,
                message: "Image should be less than 2MB"));
            return;
          }
        }
      }
      BaseResponse response = await _repository.p2pBuyProofUpload(input);
      if (response.status == 200) {
        emit(state.copyWith(
            proofUploadStatus: ProofUploadStatus.success,
            message: response.message));
      } else {
        emit(state.copyWith(
            proofUploadStatus: ProofUploadStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          proofUploadStatus: ProofUploadStatus.error, message: e.message));
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
