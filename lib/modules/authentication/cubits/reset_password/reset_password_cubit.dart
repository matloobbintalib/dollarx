import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/authentication/cubits/reset_password/reset_password_state.dart';

import '../../../../core/exceptions/api_error.dart';
import '../../models/reset_password_input.dart';
import '../../repositories/auth_repository.dart';


class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(ResetPasswordState.initial());

  AuthRepository _authRepository;

  void toggleShowPassword() => emit(state.copyWith(
    isPasswordHidden: !state.isPasswordHidden,
    resetPasswordStatus: ResetPasswordStatus.initial,
  ));

  void toggleShowConfirmPassword() => emit(state.copyWith(
    isConfirmPasswordHidden: !state.isConfirmPasswordHidden,
    resetPasswordStatus: ResetPasswordStatus.initial,
  ));

  void enableAutoValidateMode() => emit(state.copyWith(
    isAutoValidate: true,
    resetPasswordStatus: ResetPasswordStatus.initial,
  ) );

  Future<void> resetPassword(ResetPasswordInput resetPasswordInput) async {
    emit(state.copyWith(resetPasswordStatus: ResetPasswordStatus.loading));
    try {
      BaseResponse baseResponse = await _authRepository.resetPassword(resetPasswordInput);
      if (baseResponse.status == 200) {
        emit(state.copyWith(resetPasswordStatus: ResetPasswordStatus.success, message: baseResponse.message));
      } else {
        emit(state.copyWith(
            resetPasswordStatus: ResetPasswordStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          resetPasswordStatus: ResetPasswordStatus.error, message: e.message));
    }
  }
}
