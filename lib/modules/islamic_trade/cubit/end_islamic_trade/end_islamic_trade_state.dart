import 'package:dollarax/modules/islamic_trade/models/islamic_trade_items_response.dart';

enum EndIslamicTradeStatus {
  initial,
  loading,
  success,
  error,
}

class EndIslamicTradeState {
  final EndIslamicTradeStatus endIslamicTradeStatus;
  final String message;

  EndIslamicTradeState(
      {required this.endIslamicTradeStatus,
        required this.message});

  factory EndIslamicTradeState.Initial() {
    return EndIslamicTradeState(
        endIslamicTradeStatus: EndIslamicTradeStatus.initial,
        message: "");
  }

  EndIslamicTradeState copyWith({
    EndIslamicTradeStatus? endIslamicTradeStatus,
    String? message,
  }) {
    return EndIslamicTradeState(
      endIslamicTradeStatus: endIslamicTradeStatus ?? this.endIslamicTradeStatus,
      message: message ?? this.message,
    );
  }
}
