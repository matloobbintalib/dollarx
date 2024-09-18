
enum ExchangeStatus {
  none,
  loading,
  success,
  failure,
}

class ExchangeState {
  final ExchangeStatus exchangeStatus;
  final String message;

  ExchangeState({
    required this.exchangeStatus,
    this.message = '',
  });

  factory ExchangeState.initial() {
    return ExchangeState(
      exchangeStatus: ExchangeStatus.none,
      message: '',);
  }

  ExchangeState copyWith({
    ExchangeStatus? exchangeStatus,
    String? message,
  }) {
    return ExchangeState(
      exchangeStatus: exchangeStatus ?? this.exchangeStatus,
      message: message ?? this.message,
    );
  }
}
