import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/history/cubit/exchange/exchange_history_state.dart';
import 'package:dollarax/modules/history/models/exchange_history_response.dart';
import '../../../../../core/exceptions/api_error.dart';
import '../../repo/history_repo.dart';

class ExchangeHistoryCubit extends Cubit<ExchangeHistoryState> {
  final HistoryRepository _repository;

  ExchangeHistoryCubit(this._repository) : super(ExchangeHistoryState.Initial());

  Future<void> exchangeHistory() async {
    emit(state.copyWith(exchangeHistoryStatus: ExchangeHistoryStatus.loading));
    try {
      ExchangeHistoryResponse response =
      await _repository.exchangeHistory();
      if (response.status == 200) {
        emit(state.copyWith(
            exchangeHistoryStatus: ExchangeHistoryStatus.success,
            exchangeHistoryList: response.data,
            message: response.message));
      } else {
        emit(state.copyWith(
            exchangeHistoryStatus: ExchangeHistoryStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          exchangeHistoryStatus: ExchangeHistoryStatus.error, message: e.message));
    }
  }
}
