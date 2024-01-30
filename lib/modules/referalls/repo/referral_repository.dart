import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';
import '../models/referral_response.dart';

class ReferralRepository {
  final DioClient _service = sl<DioClient>();

  final _log = logger(ReferralRepository);

  Future<ReferralResponse> referralData() async {
    try {
      var response =
      await _service.post(Endpoints.referralsData);
      print('Response --- ${response.data}');
      ReferralResponse referralDataResponse = await compute(referralResponseFromJson, response.data);
      print('Response --- $response');
      return referralDataResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

}