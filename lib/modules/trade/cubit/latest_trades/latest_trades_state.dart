import 'package:dollarax/modules/trade/models/active_trade_response.dart';
import 'package:dollarax/modules/trade/models/latest_trades_response.dart';


enum LatestTradeStatus {
  initial,
  loading,
  success,
  error,
}

class LatestTradeState {
  final LatestTradeStatus latestTradeStatus;
  final List<Trade> profitTrades;
  final List<Trade> lossTrades;
  final List<Trade> buyTrades;
  final  List<Trade> sellTrades;
  final String tradeBalance;

  final String message;

  LatestTradeState({required this.latestTradeStatus,required this.profitTrades,required this.lossTrades,required this.buyTrades,required this.sellTrades,required this.message, required this.tradeBalance });

  factory LatestTradeState.Initial(){
    return LatestTradeState(latestTradeStatus: LatestTradeStatus.initial,message: "", profitTrades: [], lossTrades: [], buyTrades: [], sellTrades: [] ,tradeBalance :'');
  }



  LatestTradeState copyWith({
    LatestTradeStatus? latestTradeStatus,
    List<Trade>? profitTrades,
    List<Trade>? lossTrades,
    List<Trade>? buyTrades,
    List<Trade>? sellTrades,
    String? message,
    String? tradeBalance,
  }) {
    return LatestTradeState(
      latestTradeStatus: latestTradeStatus ?? this.latestTradeStatus,
      profitTrades: profitTrades ?? this.profitTrades,
      lossTrades: lossTrades ?? this.lossTrades,
      buyTrades: buyTrades ?? this.buyTrades,
      sellTrades: sellTrades ?? this.sellTrades,
      tradeBalance: tradeBalance ?? this.tradeBalance,
      message: message ?? this.message,
    );
  }
}
