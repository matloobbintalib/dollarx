import 'package:bloc/bloc.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/authentication/repositories/session_repository.dart';
import 'package:dollarax/modules/islamic_trade/cubit/islamic_trade_items/islamic_trade_items_state.dart';
import 'package:dollarax/modules/islamic_trade/cubit/start_islamic_trade/start_islamic_trade_state.dart';
import 'package:dollarax/modules/islamic_trade/models/islamic_trade_items_response.dart';
import 'package:dollarax/modules/islamic_trade/models/start_islamic_trade_input.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';

import '../../../../core/exceptions/api_error.dart';

class StartIslamicTradeCubit extends Cubit<StartIslamicTradeState> {
  final TradeRepository _repository;
  StartIslamicTradeCubit(this._repository) : super(StartIslamicTradeState.Initial());

  Future<void> startIslamicTrade(StartIslamicTradeInput input) async {
    emit(state.copyWith(startIslamicTradeStatus: StartIslamicTradeStatus.loading));
    try {
      BaseResponse response =
      await _repository.startIslamicTrade(input);
      if (response.status == 200) {
        emit(state.copyWith(
            startIslamicTradeStatus: StartIslamicTradeStatus.success,
            message: response.message));
      } else {
        emit(state.copyWith(
            startIslamicTradeStatus: StartIslamicTradeStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          startIslamicTradeStatus: StartIslamicTradeStatus.error, message: e.message));
    }
  }
}
