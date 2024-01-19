import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/exceptions/api_error.dart';
import '../../models/auth_response.dart';
import '../../models/login_input.dart';
import '../../repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial());

  void toggleShowPassword() => emit(state.copyWith(
        isPasswordHidden: !state.isPasswordHidden,
        loginStatus: LoginStatus.initial,
      ));

  void enableAutoValidateMode() => emit(state.copyWith(
        isAutoValidate: true,
        loginStatus: LoginStatus.initial,
      ));

  Future<void> login(LoginInput loginInput) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    try {
      AuthResponse authResponse = await _authRepository.login(loginInput);
      if (authResponse.status == 200) {
        emit(state.copyWith(loginStatus: LoginStatus.success, message: authResponse.message));
      } else {
        emit(state.copyWith(
            loginStatus: LoginStatus.error,
            message: authResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          loginStatus: LoginStatus.error, message: e.message));
    }
  }
}
