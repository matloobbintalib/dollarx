

enum StartTradeStatus {
  initial,
  loading,
  success,
  error,
}

class StartTradeState {
  final StartTradeStatus startTradeStatus;
  final String message;

  StartTradeState({required this.startTradeStatus, required this.message});

  factory StartTradeState.Initial(){
    return StartTradeState(startTradeStatus: StartTradeStatus.initial, message: "");
  }


  StartTradeState copyWith({
    StartTradeStatus? startTradeStatus,
    String? message,
  }) {
    return StartTradeState(
      startTradeStatus: startTradeStatus ?? this.startTradeStatus,
      message: message ?? this.message,
    );
  }
}
