


import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/bank_account/cubit/add_bank_info_state.dart';
import 'package:dollarax/modules/bank_account/models/bank_info_input.dart';
import 'package:dollarax/modules/bank_account/repo/bank_info_repository.dart';
import '../../../../../../core/exceptions/api_error.dart';


class BankInfoCubit extends Cubit<BankInfoState> {
  BankInfoCubit(this._repository) : super(BankInfoState.Initial());

  final BankInfoRepository _repository;

  Future<void> addBankInfo(BankInfoInput bankInfoInput) async {
    emit(state.copyWith(bankInfoStatus: BankInfoStatus.loading));
    try {
      BaseResponse baseResponse = await _repository.addBankInfo(bankInfoInput);
      if (baseResponse.status == 200) {
        emit(state.copyWith(bankInfoStatus: BankInfoStatus.success, message: baseResponse.message));
      } else {
        emit(state.copyWith(
            bankInfoStatus: BankInfoStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          bankInfoStatus: BankInfoStatus.error, message: e.message));
    }
  }
}
