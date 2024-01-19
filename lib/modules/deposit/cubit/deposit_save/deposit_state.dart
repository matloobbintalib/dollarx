

enum DepositStatus {
  initial,
  loading,
  success,
  error,
}

class DepositState {

  final DepositStatus depositStatus;
  final String message;

  DepositState({required this.depositStatus, required this.message});

  factory DepositState.Initial(){
    return DepositState(depositStatus: DepositStatus.initial, message: "");
  }


  DepositState copyWith({
    DepositStatus? depositStatus,
    String? message,
  }) {
    return DepositState(
      depositStatus: depositStatus ?? this.depositStatus,
      message: message ?? this.message,
    );
  }
}
