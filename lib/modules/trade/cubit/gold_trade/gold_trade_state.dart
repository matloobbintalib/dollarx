import 'package:dollarax/modules/trade/models/gold_trade_response.dart';

enum GoldTradeStatus {
  initial,
  loading,
  success,
  error,
}

class GoldTradeState {

  final GoldTradeStatus goldTradeStatus;
  final List<GoldTradeModel> goldTradeList;
  final String message;

  GoldTradeState( {required this.goldTradeStatus,required this.goldTradeList,required this.message });

  factory GoldTradeState.Initial(){
    return GoldTradeState(goldTradeStatus: GoldTradeStatus.initial, goldTradeList : [], message: "" );
  }



  GoldTradeState copyWith({
    GoldTradeStatus? goldTradeStatus,
    List<GoldTradeModel>? goldTradeList,
    String? message,
  }) {
    return GoldTradeState(
      goldTradeStatus: goldTradeStatus ?? this.goldTradeStatus,
      goldTradeList: goldTradeList ?? this.goldTradeList,
      message: message ?? this.message,
    );
  }
}
