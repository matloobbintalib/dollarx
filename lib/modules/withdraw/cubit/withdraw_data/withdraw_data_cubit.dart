import 'package:bloc/bloc.dart';
import 'package:dollarx/modules/deposit/models/deposit_data_response.dart';
import 'package:dollarx/modules/deposit/repo/deposit_repository.dart';
import 'package:dollarx/modules/home/repo/home_repo.dart';
import 'package:dollarx/modules/withdraw/cubit/withdraw_data/withdraw_data_state.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/exceptions/api_error.dart';
import '../../models/withdraw_data_response.dart';
import '../../repo/withdraw_repo.dart';

class WithdrawDataCubit extends Cubit<WithdrawDataState> {
  final WithdrawRepository _repository;

  WithdrawDataCubit(this._repository) : super(WithdrawDataState.Initial());

  Future<void> withdrawData() async {
    emit(state.copyWith(withdrawDataStatus: WithdrawDataStatus.loading));
    try {
      WithdrawDataResponse withdrawDataResponse = await _repository.withdrawData();
      if (withdrawDataResponse.status == 200) {
        emit(state.copyWith(
            withdrawDataStatus: WithdrawDataStatus.success,
            withdrawModel: withdrawDataResponse.data,
            message: withdrawDataResponse.message));
      } else {
        emit(state.copyWith(
            withdrawDataStatus: WithdrawDataStatus.error,
            message: withdrawDataResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          withdrawDataStatus: WithdrawDataStatus.error, message: e.message));
    }
  }
}
