

import 'package:dollarax/modules/trade/models/active_trade_response.dart';

enum TradeHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class TradeHistoryState {
  final TradeHistoryStatus tradeHistoryStatus;
  final List<ActiveTrades> tradeHistoryList;
  final String message;

  TradeHistoryState(
      {required this.tradeHistoryStatus,
        required this.tradeHistoryList,
        required this.message});

  factory TradeHistoryState.Initial() {
    return TradeHistoryState(
        tradeHistoryStatus: TradeHistoryStatus.initial,
        tradeHistoryList: [],
        message: "");
  }

  TradeHistoryState copyWith({
    TradeHistoryStatus? tradeHistoryStatus,
    List<ActiveTrades>? tradeHistoryList,
    String? message,
  }) {
    return TradeHistoryState(
      tradeHistoryStatus: tradeHistoryStatus ?? this.tradeHistoryStatus,
      tradeHistoryList: tradeHistoryList ?? this.tradeHistoryList,
      message: message ?? this.message,
    );
  }
}

