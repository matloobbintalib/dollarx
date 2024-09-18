import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/trade/cubit/gold_trade/gold_trade_state.dart';
import 'package:dollarax/modules/trade/models/gold_trade_response.dart';
import 'package:dollarax/modules/trade/models/graph_input.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class GoldTradeCubit extends Cubit<GoldTradeState> {
  final TradeRepository _repository;

  GoldTradeCubit(this._repository) : super(GoldTradeState.Initial());


  Future<void> goldTradeData(GraphInput graphInput,{bool isLoading = true}) async {
    if(isLoading){
      emit(state.copyWith(goldTradeStatus: GoldTradeStatus.loading));
    }
    try {
      GoldTradeResponse response = await _repository.goldTradeData(graphInput);
      if (response.status == 200) {
        emit(state.copyWith(
            goldTradeStatus: GoldTradeStatus.success,
            goldTradeList: response.data,
            message: response.message));
      } else {
        emit(state.copyWith(
            goldTradeStatus: GoldTradeStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          goldTradeStatus: GoldTradeStatus.error, message: e.message));
    }
  }
}
