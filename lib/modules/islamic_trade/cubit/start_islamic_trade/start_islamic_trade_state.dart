import 'package:dollarax/modules/islamic_trade/models/islamic_trade_items_response.dart';

enum StartIslamicTradeStatus {
  initial,
  loading,
  success,
  error,
}

class StartIslamicTradeState {
  final StartIslamicTradeStatus startIslamicTradeStatus;
  final String message;

  StartIslamicTradeState(
      {required this.startIslamicTradeStatus,
        required this.message});

  factory StartIslamicTradeState.Initial() {
    return StartIslamicTradeState(
        startIslamicTradeStatus: StartIslamicTradeStatus.initial,
        message: "");
  }

  StartIslamicTradeState copyWith({
    StartIslamicTradeStatus? startIslamicTradeStatus,
    String? message,
  }) {
    return StartIslamicTradeState(
      startIslamicTradeStatus: startIslamicTradeStatus ?? this.startIslamicTradeStatus,
      message: message ?? this.message,
    );
  }
}
