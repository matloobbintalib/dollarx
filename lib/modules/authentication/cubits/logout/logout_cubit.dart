import 'package:bloc/bloc.dart';
import '../../../../core/exceptions/api_error.dart';
import '../../models/base_response.dart';
import '../../repositories/auth_repository.dart';
import 'logout_state.dart';


class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepository _authRepository;
  LogoutCubit( this._authRepository) : super(LogoutState.initial());

  Future<void> logout() async {
    emit(state.copyWith(logoutStatus: LogoutStatus.loading));
    try {
      BaseResponse baseResponse = await _authRepository.logout();
      if (baseResponse.status == 200) {
        emit(state.copyWith(logoutStatus: LogoutStatus.success, message: baseResponse.message));
      } else {
        emit(state.copyWith(
            logoutStatus: LogoutStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          logoutStatus: LogoutStatus.error, message: e.message));
    }
  }
}
