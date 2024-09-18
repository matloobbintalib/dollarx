import 'package:dollarax/modules/trade/models/trade_profit_loss_grapgh_response.dart';

enum ProfitLossGraphStatus {
  initial,
  loading,
  success,
  error,
}

class ProfitLossGraphState {

  final ProfitLossGraphStatus profitLossGraphStatus;
  final TradeProfitLossGraphModel? profitLossGraphModel;
  final String message;

  ProfitLossGraphState( {required this.profitLossGraphStatus,required this.profitLossGraphModel,required this.message });

  factory ProfitLossGraphState.Initial(){
    return ProfitLossGraphState(profitLossGraphStatus: ProfitLossGraphStatus.initial, profitLossGraphModel : null, message: "" );
  }



  ProfitLossGraphState copyWith({
    ProfitLossGraphStatus? profitLossGraphStatus,
    TradeProfitLossGraphModel? profitLossGraphModel,
    String? message,
  }) {
    return ProfitLossGraphState(
      profitLossGraphStatus: profitLossGraphStatus ?? this.profitLossGraphStatus,
      profitLossGraphModel: profitLossGraphModel ?? this.profitLossGraphModel,
      message: message ?? this.message,
    );
  }
}
