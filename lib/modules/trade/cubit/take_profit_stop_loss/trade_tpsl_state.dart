import 'package:dollarax/modules/trade/models/take_profit_stop_loss_response.dart';


enum TradeTPSLStatus {
  initial,
  loading,
  success,
  error,
}

class TradeTPSLState {

  final TradeTPSLStatus tradeTPSLStatus;
  final TradeTPSLResponse? tradeTPSLResponse;
  final String message;

  TradeTPSLState( {required this.tradeTPSLStatus,required this.tradeTPSLResponse,required this.message });

  factory TradeTPSLState.Initial(){
    return TradeTPSLState(tradeTPSLStatus: TradeTPSLStatus.initial, tradeTPSLResponse : null, message: "" );
  }



  TradeTPSLState copyWith({
    TradeTPSLStatus? tradeTPSLStatus,
    TradeTPSLResponse? tradeTPSLResponse,
    String? message,
  }) {
    return TradeTPSLState(
      tradeTPSLStatus: tradeTPSLStatus ?? this.tradeTPSLStatus,
      tradeTPSLResponse: tradeTPSLResponse ?? this.tradeTPSLResponse,
      message: message ?? this.message,
    );
  }
}
