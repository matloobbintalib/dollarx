import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/trade/cubit/take_profit_stop_loss/trade_tpsl_state.dart';
import 'package:dollarax/modules/trade/models/take_profit_stop_loss_response.dart';
import 'package:dollarax/modules/trade/models/trade_tpsl_input.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';

import '../../../../../core/exceptions/api_error.dart';

class TradeTPSLCubit extends Cubit<TradeTPSLState> {
  final TradeRepository _repository;

  TradeTPSLCubit(this._repository) : super(TradeTPSLState.Initial());

  Future<void> updateTradesTPSL(TradeTPSLInput tradeTPSLInput) async {
    emit(state.copyWith(tradeTPSLStatus: TradeTPSLStatus.loading));
    try {
      TradeTPSLResponse response = await _repository.updateTradesTPSL(tradeTPSLInput);
      if (response.status == 200) {
        emit(state.copyWith(
            tradeTPSLStatus: TradeTPSLStatus.success,
            tradeTPSLResponse: response,
            message: response.message));
      } else {
        emit(state.copyWith(
            tradeTPSLStatus: TradeTPSLStatus.error,
            message: response.message,
            tradeTPSLResponse: response));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          tradeTPSLStatus: TradeTPSLStatus.error, message: e.message));
    }
  }
}
