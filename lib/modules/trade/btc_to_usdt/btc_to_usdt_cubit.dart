import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/trade/btc_to_usdt/btc_to_usdt_state.dart';
import 'package:dollarax/modules/trade/cubit/btc_graph_data/btc_graph_data_state.dart';
import 'package:dollarax/modules/trade/models/btc_to_usdt_input.dart';
import 'package:dollarax/modules/trade/models/btc_to_usdt_response.dart';
import 'package:dollarax/modules/trade/models/graph_input.dart';
import 'package:dollarax/modules/trade/models/graph_rate_response.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class BtcToUsdtCubit extends Cubit<BtcToUsdtState> {
  final TradeRepository _repository;

  BtcToUsdtCubit(this._repository) : super(BtcToUsdtState.Initial());


  Future<void> btcToUsdtData(BtcToUsdtInput graphInput) async {
    emit(state.copyWith(btcToUsdtStatus: BtcToUsdtStatus.loading));
    try {
      BtcToUsdtGraphResponse response = await _repository.btcToUsdt(graphInput);
      if (response.status == 200) {
        emit(state.copyWith(
            btcToUsdtStatus: BtcToUsdtStatus.success,
            btcToUsdtList: response.data,
            message: response.message));
      } else {
        emit(state.copyWith(
            btcToUsdtStatus: BtcToUsdtStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          btcToUsdtStatus: BtcToUsdtStatus.error, message: e.message));
    }
  }
}
