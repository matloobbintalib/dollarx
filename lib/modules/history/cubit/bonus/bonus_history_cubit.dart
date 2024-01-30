import 'package:bloc/bloc.dart';
import '../../../../../core/exceptions/api_error.dart';
import '../../models/bonus_history_response.dart';
import '../../repo/history_repo.dart';
import 'bonus_history_state.dart';

class BonusHistoryCubit extends Cubit<BonusHistoryState> {
  final HistoryRepository _repository;

  BonusHistoryCubit(this._repository) : super(BonusHistoryState.Initial());

  Future<void> bonusHistory() async {
    emit(state.copyWith(bonusHistoryStatus: BonusHistoryStatus.loading));
    try {
      BonusHistoryResponse investmentResponse =
      await _repository.bonusHistory();
      if (investmentResponse.status == 200) {
        emit(state.copyWith(
            bonusHistoryStatus: BonusHistoryStatus.success,
            bonusHistoryList: investmentResponse.data,
            message: investmentResponse.message));
      } else {
        emit(state.copyWith(
            bonusHistoryStatus: BonusHistoryStatus.error,
            message: investmentResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          bonusHistoryStatus: BonusHistoryStatus.error, message: e.message));
    }
  }
}
