import 'package:dollarax/modules/islamic_trade/models/islamic_trade_history_response.dart';
import 'package:dollarax/modules/islamic_trade/models/islamic_trade_items_response.dart';

enum IslamicTradeHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class IslamicTradeHistoryState {
  final IslamicTradeHistoryStatus islamicTradeHistoryStatus;
  final List<IslamicTradeHistoryModel> islamicTradeHistory;
  final String message;

  IslamicTradeHistoryState(
      {required this.islamicTradeHistoryStatus,
        required this.islamicTradeHistory,
        required this.message});

  factory IslamicTradeHistoryState.Initial() {
    return IslamicTradeHistoryState(
        islamicTradeHistoryStatus: IslamicTradeHistoryStatus.initial,
        islamicTradeHistory: [],
        message: "");
  }

  IslamicTradeHistoryState copyWith({
    IslamicTradeHistoryStatus? islamicTradeHistoryStatus,
    List<IslamicTradeHistoryModel>? islamicTradeHistory,
    String? message,
  }) {
    return IslamicTradeHistoryState(
      islamicTradeHistoryStatus: islamicTradeHistoryStatus ?? this.islamicTradeHistoryStatus,
      islamicTradeHistory: islamicTradeHistory?? this.islamicTradeHistory,
      message: message ?? this.message,
    );
  }
}
