


enum LogoutStatus {
  initial,
  loading,
  success,
  error,
}

class LogoutState{
  const LogoutState({
    required this.logoutStatus,
    required this.message
  });

  final String message;
  final LogoutStatus? logoutStatus;

  factory LogoutState.initial() {
    return LogoutState(
      logoutStatus: LogoutStatus.initial,
      message: '',
    );
  }

  LogoutState copyWith({
    LogoutStatus? logoutStatus,
    String? message
  }) {
    return LogoutState(
      logoutStatus: logoutStatus ?? this.logoutStatus,
      message: message ?? this.message,
    );
  }
}
