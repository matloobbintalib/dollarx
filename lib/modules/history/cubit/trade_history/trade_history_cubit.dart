import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/history/cubit/trade_history/trade_history_state.dart';
import '../../../../../core/exceptions/api_error.dart';
import '../../models/trade_history_response.dart';
import '../../repo/history_repo.dart';

class TradeHistoryCubit extends Cubit<TradeHistoryState> {
  final HistoryRepository _repository;

  TradeHistoryCubit(this._repository) : super(TradeHistoryState.Initial());

  Future<void> tradeHistory() async {
    emit(state.copyWith(tradeHistoryStatus: TradeHistoryStatus.loading));
    try {
      TradeHistoryResponse investmentResponse =
      await _repository.tradeHistory();
      if (investmentResponse.status == 200) {
        emit(state.copyWith(
            tradeHistoryStatus: TradeHistoryStatus.success,
            tradeHistoryList: investmentResponse.data,
            message: investmentResponse.message));
      } else {
        emit(state.copyWith(
            tradeHistoryStatus: TradeHistoryStatus.error,
            message: investmentResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          tradeHistoryStatus: TradeHistoryStatus.error, message: e.message));
    }
  }
}
