import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/islamic_trade/cubit/end_islamic_trade/end_islamic_trade_state.dart';
import 'package:dollarax/modules/islamic_trade/models/end_islamic_trade_input.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';

import '../../../../core/exceptions/api_error.dart';

class EndIslamicTradeCubit extends Cubit<EndIslamicTradeState> {
  final TradeRepository _repository;

  EndIslamicTradeCubit(this._repository)
      : super(EndIslamicTradeState.Initial());

  Future<void> endIslamicTrade(EndIslamicTradeInput input) async {
    emit(state.copyWith(endIslamicTradeStatus: EndIslamicTradeStatus.loading));
    try {
      BaseResponse response = await _repository.endIslamicTrade(input);
      if (response.status == 200) {
        emit(state.copyWith(
            endIslamicTradeStatus: EndIslamicTradeStatus.success,
            message: response.message));
      } else {
        emit(state.copyWith(
            endIslamicTradeStatus: EndIslamicTradeStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          endIslamicTradeStatus: EndIslamicTradeStatus.error,
          message: e.message));
    }
  }
}
