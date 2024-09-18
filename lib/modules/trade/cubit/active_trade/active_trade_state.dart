import 'package:dollarax/modules/trade/models/active_trade_response.dart';


enum ActiveTradeStatus {
  initial,
  loading,
  success,
  error,
}

class ActiveTradeState {

  final ActiveTradeStatus activeTradeStatus;
  final ActiveTradeResponse? activeTradeResponse;
  final String message;

  ActiveTradeState( {required this.activeTradeStatus,required this.activeTradeResponse,required this.message });

  factory ActiveTradeState.Initial(){
    return ActiveTradeState(activeTradeStatus: ActiveTradeStatus.initial, activeTradeResponse : null, message: "" );
  }



  ActiveTradeState copyWith({
    ActiveTradeStatus? activeTradeStatus,
    ActiveTradeResponse? activeTradeResponse,
    String? message,
  }) {
    return ActiveTradeState(
      activeTradeStatus: activeTradeStatus ?? this.activeTradeStatus,
      activeTradeResponse: activeTradeResponse ?? this.activeTradeResponse,
      message: message ?? this.message,
    );
  }
}
