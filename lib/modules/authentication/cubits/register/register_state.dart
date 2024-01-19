part of 'register_cubit.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  error,
}

class RegisterState extends Equatable {
  const RegisterState({
    required this.registerStatus,
    required this.message,
    required this.isPasswordHidden,
    required this.isConfirmPasswordHidden,
    required this.isAutoValidate,
  });

  final String message;
  final RegisterStatus? registerStatus;
  final bool isPasswordHidden;
  final bool isConfirmPasswordHidden;
  final bool isAutoValidate;

  factory RegisterState.initial() {
    return RegisterState(
      registerStatus: RegisterStatus.initial,
      isPasswordHidden: false,
      isConfirmPasswordHidden: false,
      isAutoValidate: false,
      message: '',
    );
  }

  RegisterState copyWith({
    RegisterStatus? registerStatus,
    String? message,
    bool? isPasswordHidden,
    bool? isConfirmPasswordHidden,
    bool? isAutoValidate,
  }) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
      message: message ?? this.message,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isConfirmPasswordHidden: isConfirmPasswordHidden ?? this.isConfirmPasswordHidden,
      isAutoValidate: isAutoValidate ?? this.isAutoValidate,
    );
  }

  @override
  List<Object?> get props => [registerStatus, message, isPasswordHidden,isConfirmPasswordHidden, isAutoValidate];
}
