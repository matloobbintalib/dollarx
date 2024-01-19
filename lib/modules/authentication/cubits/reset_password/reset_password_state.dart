

import 'package:equatable/equatable.dart';

enum ResetPasswordStatus {
  initial,
  loading,
  success,
  error,
}

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    required this.resetPasswordStatus,
    required this.message,
    required this.isPasswordHidden,
    required this.isConfirmPasswordHidden,
    required this.isAutoValidate,
  });

  final String message;
  final ResetPasswordStatus? resetPasswordStatus;
  final bool isPasswordHidden;
  final bool isConfirmPasswordHidden;
  final bool isAutoValidate;

  factory ResetPasswordState.initial() {
    return ResetPasswordState(
      resetPasswordStatus: ResetPasswordStatus.initial,
      isPasswordHidden: false,
      isConfirmPasswordHidden: false,
      isAutoValidate: false,
      message: '',
    );
  }

  ResetPasswordState copyWith({
    ResetPasswordStatus? resetPasswordStatus,
    String? message,
    bool? isPasswordHidden,
    bool? isConfirmPasswordHidden,
    bool? isAutoValidate,
  }) {
    return ResetPasswordState(
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
      message: message ?? this.message,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isConfirmPasswordHidden: isConfirmPasswordHidden ?? this.isConfirmPasswordHidden,
      isAutoValidate: isAutoValidate ?? this.isAutoValidate,
    );
  }

  @override
  List<Object?> get props => [resetPasswordStatus, message, isPasswordHidden,isConfirmPasswordHidden, isAutoValidate];
}
