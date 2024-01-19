

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dollarx/modules/authentication/models/base_response.dart';
import 'package:dollarx/modules/withdraw/cubit/withdraw_save/withdraw_save_state.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../../../../../core/exceptions/api_error.dart';
import '../../models/withdraw_input.dart';
import '../../repo/withdraw_repo.dart';


class WithdrawSaveCubit extends Cubit<WithdrawSaveState> {
  WithdrawSaveCubit(this._repository) : super(WithdrawSaveState.Initial());

  final WithdrawRepository _repository;

  Future<void> withdrawSave(WithdrawInput withdrawInput) async {
    MultipartFile? image ;
    emit(state.copyWith(withdrawStatus: WithdrawSaveStatus.loading));
    try {
      BaseResponse baseResponse = await _repository.withdrawSave(withdrawInput);
      if (baseResponse.status == 200) {
        emit(state.copyWith(withdrawStatus: WithdrawSaveStatus.success));
      } else {
        emit(state.copyWith(
            withdrawStatus: WithdrawSaveStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          withdrawStatus: WithdrawSaveStatus.error, message: e.message));
    }
  }
}
