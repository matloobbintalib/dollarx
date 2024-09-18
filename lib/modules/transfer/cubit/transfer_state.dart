
enum TransferStatus {
  none,
  loading,
  success,
  failure,
}

class TransferState {
  final TransferStatus transferStatus;
  final String message;

  TransferState({
    required this.transferStatus,
    this.message = '',
  });

  factory TransferState.initial() {
    return TransferState(
      transferStatus: TransferStatus.none,
      message: '',);
  }

  TransferState copyWith({
    TransferStatus? transferStatus,
    String? message,
  }) {
    return TransferState(
      transferStatus: transferStatus ?? this.transferStatus,
      message: message ?? this.message,
    );
  }
}
