import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/trade/cubit/btc_graph_data/btc_graph_data_state.dart';
import 'package:dollarax/modules/trade/models/graph_input.dart';
import 'package:dollarax/modules/trade/models/graph_rate_response.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class BtcGraphDataCubit extends Cubit<BtcGraphDataState> {
  final TradeRepository _repository;

  BtcGraphDataCubit(this._repository) : super(BtcGraphDataState.Initial());


  Future<void> btcGraphDataData(GraphInput graphInput) async {
    emit(state.copyWith(btcGraphDataStatus: BtcGraphDataStatus.loading));
    try {
      GraphRatesResponse response = await _repository.btcGraphRateData(graphInput);
      if (response.status == 200) {
        emit(state.copyWith(
            btcGraphDataStatus: BtcGraphDataStatus.success,
            btcGraphDataList: response.data,
            message: response.message));
      } else {
        emit(state.copyWith(
            btcGraphDataStatus: BtcGraphDataStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          btcGraphDataStatus: BtcGraphDataStatus.error, message: e.message));
    }
  }
}
