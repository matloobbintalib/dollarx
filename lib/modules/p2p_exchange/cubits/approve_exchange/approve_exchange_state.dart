
enum ApproveExchangeStatus {
  initial,
  loading,
  success,
  error,
}

class ApproveExchangeState {

  final ApproveExchangeStatus approveExchangeStatus;
  final String message;

  ApproveExchangeState( {required this.approveExchangeStatus,required this.message });

  factory ApproveExchangeState.Initial(){
    return ApproveExchangeState(approveExchangeStatus: ApproveExchangeStatus.initial,  message: "" );
  }



  ApproveExchangeState copyWith({
    ApproveExchangeStatus? approveExchangeStatus,
    String? message,
  }) {
    return ApproveExchangeState(
      approveExchangeStatus: approveExchangeStatus ?? this.approveExchangeStatus,
      message: message ?? this.message,
    );
  }
}
