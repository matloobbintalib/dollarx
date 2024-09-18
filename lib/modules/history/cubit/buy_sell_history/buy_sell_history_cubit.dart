import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/history/cubit/buy_sell_history/buy_sell_history_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';

import '../../../../../core/exceptions/api_error.dart';
import '../../repo/history_repo.dart';

class BuySellHistoryCubit extends Cubit<BuySellHistoryState> {
  final HistoryRepository _repository;

  BuySellHistoryCubit(this._repository) : super(BuySellHistoryState.Initial());

  Future<void> buySellExchangeHistory() async {
    emit(state.copyWith(buySellHistoryStatus: BuySellHistoryStatus.loading));
    try {
      P2PExchangeHistoryResponse investmentResponse =
          await _repository.buySellExchangeHistory();
      if (investmentResponse.status == 200) {
        emit(state.copyWith(
            buySellHistoryStatus: BuySellHistoryStatus.success,
            buySellHistoryList: investmentResponse.data,
            message: investmentResponse.message));
      } else {
        emit(state.copyWith(
            buySellHistoryStatus: BuySellHistoryStatus.error,
            message: investmentResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          buySellHistoryStatus: BuySellHistoryStatus.error,
          message: e.message));
    }
  }
}
