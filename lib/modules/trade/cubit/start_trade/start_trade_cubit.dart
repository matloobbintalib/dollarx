import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/bank_account/cubit/add_bank_info_state.dart';
import 'package:dollarax/modules/bank_account/models/bank_info_input.dart';
import 'package:dollarax/modules/bank_account/repo/bank_info_repository.dart';
import 'package:dollarax/modules/trade/cubit/start_trade/start_trade_state.dart';
import 'package:dollarax/modules/trade/models/buy_sell_input.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import '../../../../../../core/exceptions/api_error.dart';


class StartTradeCubit extends Cubit<StartTradeState> {
  StartTradeCubit(this._repository) : super(StartTradeState.Initial());

  final TradeRepository _repository;

  Future<void> startNewBuyTrade(BuySellInput input) async {
    emit(state.copyWith(startTradeStatus: StartTradeStatus.loading));
    try {
      BaseResponse baseResponse = await _repository.startNewBuyTrade(input);
      if (baseResponse.status == 200) {
        emit(state.copyWith(startTradeStatus: StartTradeStatus.success, message: baseResponse.message));
      } else {
        emit(state.copyWith(
            startTradeStatus: StartTradeStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          startTradeStatus: StartTradeStatus.error, message: e.message));
    }
  }

  Future<void> startNewSellTrade(BuySellInput input) async {
    emit(state.copyWith(startTradeStatus: StartTradeStatus.loading));
    try {
      BaseResponse baseResponse = await _repository.startNewSellTrade(input);
      if (baseResponse.status == 200) {
        emit(state.copyWith(startTradeStatus: StartTradeStatus.success, message: baseResponse.message));
      } else {
        emit(state.copyWith(
            startTradeStatus: StartTradeStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          startTradeStatus: StartTradeStatus.error, message: e.message));
    }
  }
}
