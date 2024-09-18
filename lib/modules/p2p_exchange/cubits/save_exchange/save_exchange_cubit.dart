import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_rates/exchange_rates_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/save_exchange/save_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/exchange_rate_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/save_exchange_input.dart';
import 'package:dollarax/modules/p2p_exchange/repo/p2p_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class SaveExchangeCubit extends Cubit<SaveExchangeState> {
  final P2PRepository _repository;

  SaveExchangeCubit(this._repository) : super(SaveExchangeState.Initial());


  Future<void> saveExchange(SaveExchangeInput input) async {
    emit(state.copyWith(saveExchangeStatus: SaveExchangeStatus.loading));
    try {
      BaseResponse response = await _repository.saveExchange(input);
      if (response.status == 200) {
        emit(state.copyWith(
            saveExchangeStatus: SaveExchangeStatus.success,
            message: response.message));
      } else {
        emit(state.copyWith(
            saveExchangeStatus: SaveExchangeStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          saveExchangeStatus: SaveExchangeStatus.error, message: e.message));
    }
  }
}
