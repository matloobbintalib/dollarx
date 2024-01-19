

import 'package:equatable/equatable.dart';

enum ForgotPasswordStatus {
  initial,
  loading,
  success,
  error,
}

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    required this.forgotPasswordStatus,
    required this.message
  });

  final String message;
  final ForgotPasswordStatus? forgotPasswordStatus;

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      forgotPasswordStatus: ForgotPasswordStatus.initial,
      message: '',
    );
  }

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? forgotPasswordStatus,
    String? message,
    bool? isAutoValidate,
  }) {
    return ForgotPasswordState(
      forgotPasswordStatus: forgotPasswordStatus ?? this.forgotPasswordStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [forgotPasswordStatus, message];
}
