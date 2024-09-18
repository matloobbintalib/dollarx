import 'package:dollarax/modules/p2p_exchange/cubits/buy_post_ad_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyPostAdCubit extends Cubit<BuyPostAdState> {
  BuyPostAdCubit() : super(BuyPostAdState.Initial());

  String fromCurrency = '';
  String toCurrency = '';
  String totalAmount = '0.0';
  double counterValue = 0.0;

  setCounterInitialValue() {
    counterValue = 0.0;
    totalAmount = '0.0';
    emit(state.copyWith(counterValue: counterValue, totalAmount: totalAmount));
  }

  changeFromCurrency(String currency) {
    fromCurrency = currency;
    emit(state.copyWith(fromCurrency: fromCurrency));
  }

  setInitialFromCurrency(String currency) {
    fromCurrency = currency;
    emit(state.copyWith(fromCurrency: fromCurrency));
  }

  setInitialToCurrency(String currency) {
    toCurrency = currency;
    emit(state.copyWith(fromCurrency: toCurrency));
  }

  changeToCurrency(String currency) {
    toCurrency = currency;
    emit(state.copyWith(fromCurrency: toCurrency));
  }

  changeTotalAmount(String currency) {
    totalAmount = currency;
    emit(state.copyWith(totalAmount: totalAmount));
  }

  counterValueAmount(double currency) {
    counterValue = currency;
    emit(state.copyWith(counterValue: counterValue));
  }
}
