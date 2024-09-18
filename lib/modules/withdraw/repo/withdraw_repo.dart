



import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';
import '../models/withdraw_data_response.dart';
import '../models/withdraw_input.dart';

class WithdrawRepository{
  final DioClient _service = sl<DioClient>();

  final _log = logger(WithdrawRepository);

  Future<BaseResponse> withdrawSave(WithdrawInput withdrawInput) async {
    try {
      print('Request --- ${withdrawInput.toJson()}');
      var response =
      await _service.post(Endpoints.withdrawSave, data: withdrawInput.toFormData());
      BaseResponse baseResponse = await compute(baseResponseFromJson, response.data);
      print('Response --- $response');
      return baseResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<WithdrawDataResponse> withdrawData() async {
    try {
      var response =
      await _service.get(Endpoints.withdrawsData);
      WithdrawDataResponse withdrawDataResponse = await compute(withdrawDataResponseFromJson, response.data);
      print('Response --- $response');
      return withdrawDataResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

}