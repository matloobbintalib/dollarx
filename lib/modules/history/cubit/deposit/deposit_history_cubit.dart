import 'package:bloc/bloc.dart';
import '../../../../../core/exceptions/api_error.dart';
import '../../models/deposit_history_response.dart';
import '../../repo/history_repo.dart';
import 'deposit_history_state.dart';

class DepositHistoryCubit extends Cubit<DepositHistoryState> {
  final HistoryRepository _repository;

  DepositHistoryCubit(this._repository) : super(DepositHistoryState.Initial());

  Future<void> depositHistory() async {
    emit(state.copyWith(depositHistoryStatus: DepositHistoryStatus.loading));
    try {
      DepositHistoryResponse investmentResponse =
      await _repository.depositHistory();
      if (investmentResponse.status == 200) {
        emit(state.copyWith(
            depositHistoryStatus: DepositHistoryStatus.success,
            depositHistoryList: investmentResponse.data,
            message: investmentResponse.message));
      } else {
        emit(state.copyWith(
            depositHistoryStatus: DepositHistoryStatus.error,
            message: investmentResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          depositHistoryStatus: DepositHistoryStatus.error, message: e.message));
    }
  }
}
