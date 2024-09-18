import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/history/cubit/withdraw/withdraw_history_state.dart';
import 'package:dollarax/modules/history/models/withdraw_history_response.dart';
import '../../../../core/exceptions/api_error.dart';
import '../../repo/history_repo.dart';

class WithdrawHistoryCubit extends Cubit<WithdrawHistoryState> {
  final HistoryRepository _repository;

  WithdrawHistoryCubit(this._repository) : super(WithdrawHistoryState.Initial());


  Future<void> withdrawHistory() async {
    emit(state.copyWith(withdrawHistoryStatus: WithdrawHistoryStatus.loading));
    try {
      WithdrawHistoryResponse withdrawHistoryResponse =
      await _repository.withdrawHistory();
      if (withdrawHistoryResponse.status == 200) {
        emit(state.copyWith(
            withdrawHistoryStatus: WithdrawHistoryStatus.success,
            withdrawHistoryList: withdrawHistoryResponse.data,
            message: withdrawHistoryResponse.message));
      } else {
        emit(state.copyWith(
            withdrawHistoryStatus: WithdrawHistoryStatus.error,
            message: withdrawHistoryResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          withdrawHistoryStatus: WithdrawHistoryStatus.error, message: e.message));
    }
  }
}
