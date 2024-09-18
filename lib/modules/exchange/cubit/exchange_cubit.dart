import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/exchange/models/exchange_input.dart';
import 'package:dollarax/modules/exchange/cubit/exchange_state.dart';
import 'package:dollarax/modules/exchange/repo/exchange_repo.dart';

import '../../../../core/exceptions/api_error.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  final ExchangeRepository _repository;

  ExchangeCubit(this._repository) : super(ExchangeState.initial());

  Future<void> buySellCoins(ExchangeInput exchangeInput) async {
    emit(state.copyWith(exchangeStatus: ExchangeStatus.loading));
    try {
      BaseResponse baseResponse =
      await _repository.buySellCoins(exchangeInput);
      if (baseResponse.status == 200) {
        emit(state.copyWith(
            exchangeStatus: ExchangeStatus.success,
            message: baseResponse.message));
      } else {
        emit(state.copyWith(
            exchangeStatus: ExchangeStatus.failure,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          exchangeStatus: ExchangeStatus.failure, message: e.message));
    }
  }
}
