import 'package:bloc/bloc.dart';
import 'package:dollarx/modules/withdraw/cubit/withdraw_data/withdraw_data_state.dart';

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
