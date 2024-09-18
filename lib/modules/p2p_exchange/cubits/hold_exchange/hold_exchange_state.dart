
enum HoldExchangeStatus {
  initial,
  loading,
  success,
  error,
}

class HoldExchangeState {

  final HoldExchangeStatus holdExchangeStatus;
  final String message;

  HoldExchangeState( {required this.holdExchangeStatus,required this.message });

  factory HoldExchangeState.Initial(){
    return HoldExchangeState(holdExchangeStatus: HoldExchangeStatus.initial,  message: "" );
  }



  HoldExchangeState copyWith({
    HoldExchangeStatus? holdExchangeStatus,
    String? message,
  }) {
    return HoldExchangeState(
      holdExchangeStatus: holdExchangeStatus ?? this.holdExchangeStatus,
      message: message ?? this.message,
    );
  }
}
