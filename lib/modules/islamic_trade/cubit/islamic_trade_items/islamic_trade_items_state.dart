import 'package:dollarax/modules/islamic_trade/models/islamic_trade_items_response.dart';

enum IslamicTradeItemsStatus {
  initial,
  loading,
  success,
  error,
}

class IslamicTradeItemsState {
  final IslamicTradeItemsStatus islamicTradeItemsStatus;
  final List<IslamicTradeItemModel> islamicTradeItems;
  final String tradeBalance;
  final String totalROI;
  final String message;

  IslamicTradeItemsState(
      {required this.islamicTradeItemsStatus,
        required this.islamicTradeItems,
        required this.tradeBalance,
        required this.totalROI,
        required this.message});

  factory IslamicTradeItemsState.Initial() {
    return IslamicTradeItemsState(
        islamicTradeItemsStatus: IslamicTradeItemsStatus.initial,
        islamicTradeItems: [],
        tradeBalance: '0.0',
        totalROI: '0.0',
        message: "");
  }

  IslamicTradeItemsState copyWith({
    IslamicTradeItemsStatus? islamicTradeItemsStatus,
    List<IslamicTradeItemModel>? islamicTradeItems,
    String? tradeBalance,
    String? totalROI,
    String? message,
  }) {
    return IslamicTradeItemsState(
      islamicTradeItemsStatus: islamicTradeItemsStatus ?? this.islamicTradeItemsStatus,
      islamicTradeItems: islamicTradeItems?? this.islamicTradeItems,
      tradeBalance: tradeBalance?? this.tradeBalance,
      totalROI: totalROI?? this.totalROI,
      message: message ?? this.message,
    );
  }
}
