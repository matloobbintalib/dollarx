class BuyPostAdState {

  final String fromCurrency;
  final String toCurrency;
  final String totalAmount;
  final double counterValue;

  BuyPostAdState( {required this.fromCurrency ,required this.toCurrency,required this.totalAmount,required this.counterValue});

  factory BuyPostAdState.Initial(){
    return BuyPostAdState(  fromCurrency: "" ,toCurrency: "",totalAmount:'0.0',counterValue:0.0);
  }



  BuyPostAdState copyWith({

    String? fromCurrency,
    String? toCurrency,
    String? totalAmount,
    double? counterValue,
  }) {
    return BuyPostAdState(
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      totalAmount: totalAmount ?? this.totalAmount,
      counterValue: counterValue ?? this.counterValue,
    );
  }
}