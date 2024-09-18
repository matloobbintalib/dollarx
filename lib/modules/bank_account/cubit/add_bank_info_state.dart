

enum BankInfoStatus {
  initial,
  loading,
  success,
  error,
}

class BankInfoState {
  final BankInfoStatus bankInfoStatus;
  final String message;

  BankInfoState({required this.bankInfoStatus, required this.message});

  factory BankInfoState.Initial(){
    return BankInfoState(bankInfoStatus: BankInfoStatus.initial, message: "");
  }


  BankInfoState copyWith({
    BankInfoStatus? bankInfoStatus,
    String? message,
  }) {
    return BankInfoState(
      bankInfoStatus: bankInfoStatus ?? this.bankInfoStatus,
      message: message ?? this.message,
    );
  }
}
