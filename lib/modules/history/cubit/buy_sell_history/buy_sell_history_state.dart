
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
enum BuySellHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class BuySellHistoryState {
  final BuySellHistoryStatus buySellHistoryStatus;
  final List<P2PExchangeModel> buySellHistoryList;
  final String message;

  BuySellHistoryState(
      {required this.buySellHistoryStatus,
        required this.buySellHistoryList,
        required this.message});

  factory BuySellHistoryState.Initial() {
    return BuySellHistoryState(
        buySellHistoryStatus: BuySellHistoryStatus.initial,
        buySellHistoryList: [],
        message: "");
  }

  BuySellHistoryState copyWith({
    BuySellHistoryStatus? buySellHistoryStatus,
    List<P2PExchangeModel>? buySellHistoryList,
    String? message,
  }) {
    return BuySellHistoryState(
      buySellHistoryStatus: buySellHistoryStatus ?? this.buySellHistoryStatus,
      buySellHistoryList: buySellHistoryList ?? this.buySellHistoryList,
      message: message ?? this.message,
    );
  }
}

