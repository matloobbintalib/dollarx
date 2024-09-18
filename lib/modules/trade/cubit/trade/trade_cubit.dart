import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/trade/cubit/trade/trade_state.dart';
import 'package:dollarax/modules/trade/models/trade_dashboard_response.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class TradeCubit extends Cubit<TradeState> {
  final TradeRepository _repository;

  TradeCubit(this._repository) : super(TradeState.Initial());


  Future<void> tradeData() async {
    emit(state.copyWith(tradeStatus: TradeStatus.loading));
    try {
      TradeDashboardResponse tradeResponse = await _repository.getTradeDashboardData();
      if (tradeResponse.status == 200) {
        emit(state.copyWith(
            tradeStatus: TradeStatus.success,
            tradeDataModel: tradeResponse.data,
            message: tradeResponse.message));
      } else {
        emit(state.copyWith(
            tradeStatus: TradeStatus.error,
            message: tradeResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          tradeStatus: TradeStatus.error, message: e.message));
    }
  }
}
