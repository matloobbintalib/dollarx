
enum RefreshHoldStatus {
  initial,
  loading,
  success,
  error,
}

class RefreshHoldState {

  final RefreshHoldStatus refreshHoldStatus;
  final String message;

  RefreshHoldState( {required this.refreshHoldStatus,required this.message });

  factory RefreshHoldState.Initial(){
    return RefreshHoldState(refreshHoldStatus: RefreshHoldStatus.initial,  message: "" );
  }



  RefreshHoldState copyWith({
    RefreshHoldStatus? refreshHoldStatus,
    String? message,
  }) {
    return RefreshHoldState(
      refreshHoldStatus: refreshHoldStatus ?? this.refreshHoldStatus,
      message: message ?? this.message,
    );
  }
}
