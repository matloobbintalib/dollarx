import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_rates/exchange_rates_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/exchange_rate_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/repo/p2p_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  final P2PRepository _repository;

  ExchangeRateCubit(this._repository) : super(ExchangeRateState.Initial());


  Future<void> getExchangeRate(String sellCurrency, String buyCurrency, String type) async {
    emit(state.copyWith(exchangeRateStatus: ExchangeRateStatus.loading));
    try {
      ExchangeRateResponse response = await _repository.getExchangeRate(sellCurrency, buyCurrency,type);
      if (response.status == 200) {
        emit(state.copyWith(
            exchangeRateStatus: ExchangeRateStatus.success,
            rate: response.data,
            message: response.message));
      } else {
        emit(state.copyWith(
            exchangeRateStatus: ExchangeRateStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          exchangeRateStatus: ExchangeRateStatus.error, message: e.message));
    }
  }
}
