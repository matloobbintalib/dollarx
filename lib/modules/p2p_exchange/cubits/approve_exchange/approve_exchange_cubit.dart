import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/approve_exchange/approve_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_rates/exchange_rates_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/hold_exchange/hold_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/save_exchange/save_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/exchange_rate_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_approved_exchange_input.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/save_exchange_input.dart';
import 'package:dollarax/modules/p2p_exchange/repo/p2p_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class ApproveExchangeCubit extends Cubit<ApproveExchangeState> {
  final P2PRepository _repository;

  ApproveExchangeCubit(this._repository) : super(ApproveExchangeState.Initial());


  Future<void> p2pApprovedBuyExchange(P2pApprovedExchangeInput input) async {
    emit(state.copyWith(approveExchangeStatus: ApproveExchangeStatus.loading));
    try {
      BaseResponse response = await _repository.p2pApprovedBuyExchange(input);
      if (response.status == 200) {
        emit(state.copyWith(
            approveExchangeStatus: ApproveExchangeStatus.success,
            message: response.message));
      } else {
        emit(state.copyWith(
            approveExchangeStatus: ApproveExchangeStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          approveExchangeStatus: ApproveExchangeStatus.error, message: e.message));
    }
  }

  Future<void> p2pApprovedSellExchange(P2pApprovedExchangeInput input) async {
    emit(state.copyWith(approveExchangeStatus: ApproveExchangeStatus.loading));
    try {
      BaseResponse response = await _repository.p2pApprovedSellExchange(input);
      if (response.status == 200) {
        emit(state.copyWith(
            approveExchangeStatus: ApproveExchangeStatus.success,
            message: response.message));
      } else {
        emit(state.copyWith(
            approveExchangeStatus: ApproveExchangeStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          approveExchangeStatus: ApproveExchangeStatus.error, message: e.message));
    }
  }
}
