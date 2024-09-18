import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/trade/cubit/active_trade/active_trade_state.dart';
import 'package:dollarax/modules/trade/cubit/btc_graph_data/btc_graph_data_state.dart';
import 'package:dollarax/modules/trade/models/active_trade_response.dart';
import 'package:dollarax/modules/trade/models/graph_rate_response.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class ActiveTradeCubit extends Cubit<ActiveTradeState> {
  final TradeRepository _repository;

  ActiveTradeCubit(this._repository) : super(ActiveTradeState.Initial());


  Future<void> activeTradeData({bool isLoading = false}) async {
    if(isLoading){
      emit(state.copyWith(activeTradeStatus: ActiveTradeStatus.loading));
    }
    try {
      ActiveTradeResponse response = await _repository.activeTrade();
      if (response.status == 200) {
        emit(state.copyWith(
            activeTradeStatus: ActiveTradeStatus.success,
            activeTradeResponse: response,
            message: response.message));
      } else {
        emit(state.copyWith(
            activeTradeStatus: ActiveTradeStatus.error,
            message: response.message,activeTradeResponse: response));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          activeTradeStatus: ActiveTradeStatus.error, message: e.message));
    }
  }
}
