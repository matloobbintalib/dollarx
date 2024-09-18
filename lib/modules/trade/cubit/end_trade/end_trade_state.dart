

enum EndTradeStatus {
  initial,
  loading,
  success,
  error,
}

class EndTradeState {
  final EndTradeStatus endTradeStatus;
  final String message;

  EndTradeState({required this.endTradeStatus, required this.message});

  factory EndTradeState.Initial(){
    return EndTradeState(endTradeStatus: EndTradeStatus.initial, message: "");
  }


  EndTradeState copyWith({
    EndTradeStatus? endTradeStatus,
    String? message,
  }) {
    return EndTradeState(
      endTradeStatus: endTradeStatus ?? this.endTradeStatus,
      message: message ?? this.message,
    );
  }
}
