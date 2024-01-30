

enum DepositSoldStatus {
  initial,
  loading,
  success,
  error,
}

class DepositSoldState {

  final DepositSoldStatus depositSoldStatus;
  final String message;

  DepositSoldState({required this.depositSoldStatus, required this.message});

  factory DepositSoldState.Initial(){
    return DepositSoldState(depositSoldStatus: DepositSoldStatus.initial, message: "");
  }


  DepositSoldState copyWith({
    DepositSoldStatus? depositSoldStatus,
    String? message,
  }) {
    return DepositSoldState(
      depositSoldStatus: depositSoldStatus ?? this.depositSoldStatus,
      message: message ?? this.message,
    );
  }
}
