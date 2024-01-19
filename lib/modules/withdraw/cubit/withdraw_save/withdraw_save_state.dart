

enum WithdrawSaveStatus {
  initial,
  loading,
  success,
  error,
}

class WithdrawSaveState {
  final WithdrawSaveStatus withdrawStatus;
  final String message;

  WithdrawSaveState({required this.withdrawStatus, required this.message});

  factory WithdrawSaveState.Initial(){
    return WithdrawSaveState(withdrawStatus: WithdrawSaveStatus.initial, message: "");
  }


  WithdrawSaveState copyWith({
    WithdrawSaveStatus? withdrawStatus,
    String? message,
  }) {
    return WithdrawSaveState(
      withdrawStatus: withdrawStatus ?? this.withdrawStatus,
      message: message ?? this.message,
    );
  }
}
