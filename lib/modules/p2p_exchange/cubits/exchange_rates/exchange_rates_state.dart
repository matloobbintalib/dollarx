
import 'package:dollarax/modules/p2p_exchange/models/exchange_rate_response.dart';

enum ExchangeRateStatus {
  initial,
  loading,
  success,
  error,
}

class ExchangeRateState {

  final ExchangeRateStatus exchangeRateStatus;
  final ExchangeRateModel rate;
  final String message;

  ExchangeRateState( {required this.exchangeRateStatus,required this.rate,required this.message });

  factory ExchangeRateState.Initial(){
    return ExchangeRateState(exchangeRateStatus: ExchangeRateStatus.initial, rate : ExchangeRateModel(exchangeRate: '',currenyBalance: '',crypto_rate:''), message: "" );
  }



  ExchangeRateState copyWith({
    ExchangeRateStatus? exchangeRateStatus,
    ExchangeRateModel? rate,
    String? message,
  }) {
    return ExchangeRateState(
      exchangeRateStatus: exchangeRateStatus ?? this.exchangeRateStatus,
      rate: rate ?? this.rate,
      message: message ?? this.message,
    );
  }
}
