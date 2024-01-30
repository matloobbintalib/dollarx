import 'package:dio/dio.dart';
import 'package:dollarx/modules/authentication/models/reset_password_input.dart';
import 'package:dollarx/modules/authentication/models/verify_otp_input.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';
import '../../user/models/user_model.dart';
import '../../user/repository/user_account_repository.dart';
import '../models/auth_response.dart';
import '../models/base_response.dart';
import '../models/forgot_password_input.dart';
import '../models/login_input.dart';
import '../models/register_input.dart';
import 'session_repository.dart';

class AuthRepository {
  final DioClient _dioClient;
  final UserAccountRepository _userAccountRepository;
  final SessionRepository _sessionRepository;

  final _log = logger(AuthRepository);

  AuthRepository({
    required DioClient dioClient,
    required UserAccountRepository userAccountRepository,
    required SessionRepository sessionRepository,
  })  : _dioClient = dioClient,
        _sessionRepository = sessionRepository,
        _userAccountRepository = userAccountRepository;

  Future<AuthResponse> login(LoginInput loginInput) async {
    try {
      var response =
          await _dioClient.post(Endpoints.login, data: loginInput.toFormData());
      AuthResponse authResponse = AuthResponse.fromJson(response.data);
      UserModel userModel = authResponse.data.user;
      await _userAccountRepository.saveUserInDb(userModel);
      await _sessionRepository.setToken(authResponse.token);
      await _dioClient.setToken(authResponse.token);
      await _sessionRepository.setLoggedIn(true);
      return authResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<AuthResponse> register(RegisterInput signupInput) async {
    try {
      var response = await _dioClient.post(Endpoints.register,data: signupInput.toFormData());
      print('Response --- ${response.data}');
      AuthResponse authResponse = AuthResponse.fromJson(response.data);
      UserModel userModel = authResponse.data.user;
      await _userAccountRepository.saveUserInDb(userModel);
      await _sessionRepository.setToken(authResponse.token);
      await _dioClient.setToken(authResponse.token);
      await _sessionRepository.setLoggedIn(true);
      return authResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<BaseResponse> resetPassword(ResetPasswordInput resetPasswordInput) async {
    try {
      var response = await _dioClient.post(Endpoints.resetPassword,data: resetPasswordInput.toFormData());
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      return baseResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<BaseResponse> forgotPassword(ForgotPasswordInput forgotPasswordInput) async {
    try {
      var response = await _dioClient.post(Endpoints.forgotPassword,data: forgotPasswordInput.toFormData());
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      return baseResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
  Future<BaseResponse> verifyOtp(VerifyOtpInput input) async {
    try {
      var response = await _dioClient.post(Endpoints.verifyOtp,data: input.toFormData());
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      return baseResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<BaseResponse> logout() async {
    try {
      var response = await _dioClient.post(Endpoints.logout);
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      return baseResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
}
