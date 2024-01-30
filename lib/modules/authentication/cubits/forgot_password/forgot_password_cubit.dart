import 'package:bloc/bloc.dart';

import '../../../../core/exceptions/api_error.dart';
import '../../models/base_response.dart';
import '../../models/forgot_password_input.dart';
import '../../repositories/auth_repository.dart';
import 'forgot_password_state.dart';


class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(ForgotPasswordState.initial());

  AuthRepository _authRepository;


  Future<void> forgotPassword(ForgotPasswordInput forgotPasswordInput) async {
    emit(state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.loading));
    try {
      BaseResponse baseResponse = await _authRepository.forgotPassword(forgotPasswordInput);
      if (baseResponse.status == 200) {
        emit(state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.success, message: baseResponse.message));
      } else {
        emit(state.copyWith(
            forgotPasswordStatus: ForgotPasswordStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          forgotPasswordStatus: ForgotPasswordStatus.error, message: e.message));
    }
  }
}
