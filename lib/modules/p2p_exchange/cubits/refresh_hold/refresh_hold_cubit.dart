import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_rates/exchange_rates_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/hold_exchange/hold_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/refresh_hold/refresh_hold_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/save_exchange/save_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/exchange_rate_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/save_exchange_input.dart';
import 'package:dollarax/modules/p2p_exchange/repo/p2p_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class RefreshHoldCubit extends Cubit<RefreshHoldState> {
  final P2PRepository _repository;

  RefreshHoldCubit(this._repository) : super(RefreshHoldState.Initial());


  Future<void> p2PRefreshHold(int id) async {
    emit(state.copyWith(refreshHoldStatus: RefreshHoldStatus.loading));
    try {
      bool response = await _repository.p2PRefreshHold(id);
      if (response) {
        emit(state.copyWith(
            refreshHoldStatus: RefreshHoldStatus.success,
            message: ""));
      } else {
        emit(state.copyWith(
            refreshHoldStatus: RefreshHoldStatus.error,
            message: "This exchange hold by the other person"));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          refreshHoldStatus: RefreshHoldStatus.error, message: e.message));
    }
  }
}
