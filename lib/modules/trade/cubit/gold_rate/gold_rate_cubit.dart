import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/trade/cubit/gold_rate/gold_rate_state.dart';
import 'package:dollarax/modules/trade/cubit/gold_trade/gold_trade_state.dart';
import 'package:dollarax/modules/trade/models/gold_trade_response.dart';
import 'package:dollarax/modules/trade/models/graph_input.dart';
import 'package:dollarax/modules/trade/models/latest_gold_rate_response.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class GoldRateCubit extends Cubit<GoldRateState> {
  final TradeRepository _repository;

  GoldRateCubit(this._repository) : super(GoldRateState.Initial());
  
  Future<void> goldLatestRate() async {
    emit(state.copyWith(goldRateStatus: GoldRateStatus.loading));
    try {
      GoldLatestRateResponse response = await _repository.goldLatestRate();
      if (response.status == 200) {
        emit(state.copyWith(
            goldRateStatus: GoldRateStatus.success,
            goldLatestRateModel: response.data,
            message: response.message));
      } else {
        emit(state.copyWith(
            goldRateStatus: GoldRateStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          goldRateStatus: GoldRateStatus.error, message: e.message));
    }
  }
}
