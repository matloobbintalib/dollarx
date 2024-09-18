import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/trade/cubit/active_trade/active_trade_state.dart';
import 'package:dollarax/modules/trade/cubit/btc_graph_data/btc_graph_data_state.dart';
import 'package:dollarax/modules/trade/cubit/latest_trades/latest_trades_state.dart';
import 'package:dollarax/modules/trade/models/active_trade_response.dart';
import 'package:dollarax/modules/trade/models/graph_rate_response.dart';
import 'package:dollarax/modules/trade/models/latest_trades_response.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class LatestTradeCubit extends Cubit<LatestTradeState> {
  final TradeRepository _repository;

  LatestTradeCubit(this._repository) : super(LatestTradeState.Initial());


  Future<void> latestTradeData({bool isLoading = false}) async {
    if(isLoading){
      emit(state.copyWith(latestTradeStatus: LatestTradeStatus.loading));
    }
    try {
      LatestTradesResponse response = await _repository.latestTrades();
      if (response.status == 200) {
        emit(state.copyWith(
            latestTradeStatus: LatestTradeStatus.success,
            buyTrades: response.data.buyTrades,
            sellTrades: response.data.sellTrades,
            tradeBalance: response.data.tradeBalance,
            message: response.message));
      } else {
        emit(state.copyWith(
            latestTradeStatus: LatestTradeStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          latestTradeStatus: LatestTradeStatus.error, message: e.message));
    }
  }
}
