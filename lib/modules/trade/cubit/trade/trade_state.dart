
import 'package:dollarax/modules/trade/cubit/trade/trade_state.dart';
import 'package:dollarax/modules/trade/models/trade_dashboard_response.dart';

enum TradeStatus {
  initial,
  loading,
  success,
  error,
}

class TradeState {

  final TradeStatus tradeStatus;
  final TradeDataModel? tradeDataModel;
  final String message;

  TradeState( {required this.tradeStatus,required this.tradeDataModel,required this.message });

  factory TradeState.Initial(){
    return TradeState(tradeStatus: TradeStatus.initial, tradeDataModel : null, message: "" );
  }



  TradeState copyWith({
    TradeStatus? tradeStatus,
    TradeDataModel? tradeDataModel,
    String? message,
  }) {
    return TradeState(
      tradeStatus: tradeStatus ?? this.tradeStatus,
      tradeDataModel: tradeDataModel ?? this.tradeDataModel,
      message: message ?? this.message,
    );
  }
}
