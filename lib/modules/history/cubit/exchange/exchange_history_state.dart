
import 'package:dollarax/modules/history/models/exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';

enum ExchangeHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class ExchangeHistoryState {
  final ExchangeHistoryStatus exchangeHistoryStatus;
  final List<ExchangeHistoryModel> exchangeHistoryList;
  final String message;

  ExchangeHistoryState(
      {required this.exchangeHistoryStatus,
        required this.exchangeHistoryList,
        required this.message});

  factory ExchangeHistoryState.Initial() {
    return ExchangeHistoryState(
        exchangeHistoryStatus: ExchangeHistoryStatus.initial,
        exchangeHistoryList: [],
        message: "");
  }

  ExchangeHistoryState copyWith({
    ExchangeHistoryStatus? exchangeHistoryStatus,
    List<ExchangeHistoryModel>? exchangeHistoryList,
    String? message,
  }) {
    return ExchangeHistoryState(
      exchangeHistoryStatus: exchangeHistoryStatus ?? this.exchangeHistoryStatus,
      exchangeHistoryList: exchangeHistoryList ?? this.exchangeHistoryList,
      message: message ?? this.message,
    );
  }
}

