

import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';
import '../../authentication/models/auth_response.dart';
import '../../user/models/user_model.dart';
import '../../user/repository/user_account_repository.dart';
import '../models/update_profile_input.dart';

class ProfileRepository{
  final DioClient _dioClient;
  final _log = logger(ProfileRepository);
  ProfileRepository( {
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  Future<BaseResponse> updateProfile( UpdateProfileInput updateProfileInput) async {
    try {
      print("Request--${updateProfileInput.toJson()}");
      var response =
      await _dioClient.post(Endpoints.update_profile, data: updateProfileInput.toFormData());
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