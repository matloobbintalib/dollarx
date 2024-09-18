import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/trade/cubit/btc_graph_data/btc_graph_data_state.dart';
import 'package:dollarax/modules/trade/cubit/profit_loss_graph/profit_loss_graph_state.dart';
import 'package:dollarax/modules/trade/models/graph_input.dart';
import 'package:dollarax/modules/trade/models/graph_rate_response.dart';
import 'package:dollarax/modules/trade/models/trade_profit_loss_grapgh_response.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class ProfitLossGraphCubit extends Cubit<ProfitLossGraphState> {
  final TradeRepository _repository;

  ProfitLossGraphCubit(this._repository) : super(ProfitLossGraphState.Initial());


  Future<void> tradeProfitLossGraph(GraphInput graphInput) async {
    emit(state.copyWith(profitLossGraphStatus: ProfitLossGraphStatus.loading));
    try {
      TradeProfitLossGraphResponse response = await _repository.tradeProfitLossGraph(graphInput);
      if (response.status == 200) {
        emit(state.copyWith(
            profitLossGraphStatus: ProfitLossGraphStatus.success,
            profitLossGraphModel: response.data,
            message: response.message));
      } else {
        emit(state.copyWith(
            profitLossGraphStatus: ProfitLossGraphStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          profitLossGraphStatus: ProfitLossGraphStatus.error, message: e.message));
    }
  }
}
