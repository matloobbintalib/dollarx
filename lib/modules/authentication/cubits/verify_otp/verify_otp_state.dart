

import 'package:equatable/equatable.dart';

enum VerifyOtpStatus {
  initial,
  loading,
  success,
  error,
}

class VerifyOtpState extends Equatable {
  const VerifyOtpState({
    required this.verifyOtpStatus,
    required this.message
  });

  final String message;
  final VerifyOtpStatus? verifyOtpStatus;

  factory VerifyOtpState.initial() {
    return VerifyOtpState(
      verifyOtpStatus: VerifyOtpStatus.initial,
      message: '',
    );
  }

  VerifyOtpState copyWith({
    VerifyOtpStatus? verifyOtpStatus,
    String? message,
  }) {
    return VerifyOtpState(
      verifyOtpStatus: verifyOtpStatus ?? this.verifyOtpStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [verifyOtpStatus, message];
}
