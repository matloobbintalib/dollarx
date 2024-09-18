import 'package:bloc/bloc.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/authentication/repositories/session_repository.dart';
import 'package:dollarax/modules/islamic_trade/cubit/islamic_trade_items/islamic_trade_items_state.dart';
import 'package:dollarax/modules/islamic_trade/models/islamic_trade_items_response.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';

import '../../../../core/exceptions/api_error.dart';

class IslamicTradeItemsCubit extends Cubit<IslamicTradeItemsState> {
  final TradeRepository _repository;
  final SessionRepository _sessionRepository = sl<SessionRepository>();

  IslamicTradeItemsCubit(this._repository) : super(IslamicTradeItemsState.Initial());

  Future<void> getIslamicTradeItems() async {
    emit(state.copyWith(islamicTradeItemsStatus: IslamicTradeItemsStatus.loading));
    try {
      IslamicTradItemsResponse islamicTradeItemsResponse =
      await _repository.getIslamicTradeItems();
      String tradeBalance = await _sessionRepository.getTradeBalance();
      String tradeROI = await _sessionRepository.getTradeROI();
      if (islamicTradeItemsResponse.status == 200) {
        emit(state.copyWith(
            islamicTradeItemsStatus: IslamicTradeItemsStatus.success,
            islamicTradeItems: islamicTradeItemsResponse.data,
            tradeBalance:tradeBalance ,
            totalROI: tradeROI,
            message: islamicTradeItemsResponse.message));
      } else {
        emit(state.copyWith(
            islamicTradeItemsStatus: IslamicTradeItemsStatus.error,
            message: islamicTradeItemsResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          islamicTradeItemsStatus: IslamicTradeItemsStatus.error, message: e.message));
    }
  }
}
