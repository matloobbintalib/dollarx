import 'package:bloc/bloc.dart';
import 'package:dollarx/modules/authentication/cubits/verify_otp/verify_otp_state.dart';
import 'package:dollarx/modules/authentication/models/verify_otp_input.dart';

import '../../../../core/exceptions/api_error.dart';
import '../../models/base_response.dart';
import '../../repositories/auth_repository.dart';



class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(VerifyOtpState.initial());

  AuthRepository _authRepository;
  
  Future<void> verifyOtp(VerifyOtpInput input) async {
    emit(state.copyWith(verifyOtpStatus: VerifyOtpStatus.loading));
    try {
      BaseResponse baseResponse = await _authRepository.verifyOtp(input);
      if (baseResponse.status == 200) {
        emit(state.copyWith(verifyOtpStatus: VerifyOtpStatus.success, message: baseResponse.message));
      } else {
        emit(state.copyWith(
            verifyOtpStatus: VerifyOtpStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          verifyOtpStatus: VerifyOtpStatus.error, message: e.message));
    }
  }
}
