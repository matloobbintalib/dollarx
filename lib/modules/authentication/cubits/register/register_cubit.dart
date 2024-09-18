import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dollarax/modules/authentication/models/register_input.dart';

import '../../../../core/exceptions/api_error.dart';
import '../../models/auth_response.dart';
import '../../repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(RegisterState.initial());

  AuthRepository _authRepository;

  void toggleShowPassword() => emit(state.copyWith(
        isPasswordHidden: !state.isPasswordHidden,
        registerStatus: RegisterStatus.initial,
      ));

  void toggleShowConfirmPassword() => emit(state.copyWith(
    isConfirmPasswordHidden: !state.isConfirmPasswordHidden,
    registerStatus: RegisterStatus.initial,
  ));

  void enableAutoValidateMode() => emit(state.copyWith(
        isAutoValidate: true,
        registerStatus: RegisterStatus.initial,
      ) );

  Future<void> register(RegisterInput signupInput) async {
    emit(state.copyWith(registerStatus: RegisterStatus.loading));
    try {
      AuthResponse authResponse = await _authRepository.register(signupInput);
      if (authResponse.status == 200) {
        emit(state.copyWith(registerStatus: RegisterStatus.success, message: authResponse.message));
      } else {
        emit(state.copyWith(
            registerStatus: RegisterStatus.error,
            message: authResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          registerStatus: RegisterStatus.error, message: e.message));
    }
  }
}
