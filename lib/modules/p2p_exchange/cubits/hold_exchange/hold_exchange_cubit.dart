import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_rates/exchange_rates_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/hold_exchange/hold_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/save_exchange/save_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/exchange_rate_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/save_exchange_input.dart';
import 'package:dollarax/modules/p2p_exchange/repo/p2p_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class HoldExchangeCubit extends Cubit<HoldExchangeState> {
  final P2PRepository _repository;

  HoldExchangeCubit(this._repository) : super(HoldExchangeState.Initial());


  Future<void> p2pHoldBuy(int id) async {
    emit(state.copyWith(holdExchangeStatus: HoldExchangeStatus.loading));
    try {
      BaseResponse response = await _repository.p2pHoldBuy(id);
      if (response.status == 200) {
        emit(state.copyWith(
            holdExchangeStatus: HoldExchangeStatus.success,
            message: response.message));
      } else {
        emit(state.copyWith(
            holdExchangeStatus: HoldExchangeStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          holdExchangeStatus: HoldExchangeStatus.error, message: e.message));
    }
  }

  Future<void> p2pHoldSell(int id) async {
    emit(state.copyWith(holdExchangeStatus: HoldExchangeStatus.loading));
    try {
      BaseResponse response = await _repository.p2pHoldSell(id);
      if (response.status == 200) {
        emit(state.copyWith(
            holdExchangeStatus: HoldExchangeStatus.success,
            message: response.message));
      } else {
        emit(state.copyWith(
            holdExchangeStatus: HoldExchangeStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          holdExchangeStatus: HoldExchangeStatus.error, message: e.message));
    }
  }
}
