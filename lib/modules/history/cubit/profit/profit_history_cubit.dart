import 'package:bloc/bloc.dart';
import '../../../../../core/exceptions/api_error.dart';
import '../../models/profit_history_response.dart';
import '../../repo/history_repo.dart';
import 'profit_history_state.dart';

class ProfitHistoryCubit extends Cubit<ProfitHistoryState> {
  final HistoryRepository _repository;

  ProfitHistoryCubit(this._repository) : super(ProfitHistoryState.Initial());

  Future<void> profitHistory() async {
    emit(state.copyWith(profitHistoryStatus: ProfitHistoryStatus.loading));
    try {
      ProfitHistoryResponse investmentResponse =
      await _repository.profitHistory();
      if (investmentResponse.status == 200) {
        emit(state.copyWith(
            profitHistoryStatus: ProfitHistoryStatus.success,
            profitHistoryList: investmentResponse.data,
            message: investmentResponse.message));
      } else {
        emit(state.copyWith(
            profitHistoryStatus: ProfitHistoryStatus.error,
            message: investmentResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          profitHistoryStatus: ProfitHistoryStatus.error, message: e.message));
    }
  }
}
