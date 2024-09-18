import 'package:bloc/bloc.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/authentication/repositories/session_repository.dart';
import 'package:dollarax/modules/islamic_trade/cubit/islamic_trade_history/islamic_trade_history_state.dart';
import 'package:dollarax/modules/islamic_trade/cubit/islamic_trade_items/islamic_trade_items_state.dart';
import 'package:dollarax/modules/islamic_trade/models/islamic_trade_history_response.dart';
import 'package:dollarax/modules/islamic_trade/models/islamic_trade_items_response.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';

import '../../../../core/exceptions/api_error.dart';

class IslamicTradeHistoryCubit extends Cubit<IslamicTradeHistoryState> {
  final TradeRepository _repository;
  final SessionRepository _sessionRepository = sl<SessionRepository>();

  IslamicTradeHistoryCubit(this._repository) : super(IslamicTradeHistoryState.Initial());

  Future<void> getIslamicTradeHistory() async {
    emit(state.copyWith(islamicTradeHistoryStatus: IslamicTradeHistoryStatus.loading));
    try {
      IslamicTradeHistoryResponse response =
      await _repository.islamicTradesHistory();
      if (response.status == 200) {
        emit(state.copyWith(
            islamicTradeHistoryStatus: IslamicTradeHistoryStatus.success,
            islamicTradeHistory: response.data,
            message: response.message));
      } else {
        emit(state.copyWith(
            islamicTradeHistoryStatus: IslamicTradeHistoryStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          islamicTradeHistoryStatus: IslamicTradeHistoryStatus.error, message: e.message));
    }
  }
}
