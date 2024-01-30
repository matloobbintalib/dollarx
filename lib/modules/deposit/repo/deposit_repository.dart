



import 'package:dio/dio.dart';
import 'package:dollarx/modules/authentication/models/base_response.dart';
import 'package:dollarx/modules/deposit/models/deposit_data_response.dart';
import 'package:dollarx/modules/deposit/models/deposit_input.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';

class DepositRepository{
  final DioClient _service = sl<DioClient>();

  final _log = logger(DepositRepository);

  Future<BaseResponse> depositSave(DepositInput depositInput) async {
    try {
      print('Request --- ${depositInput.toJson()}');
      var response =
      await _service.post(Endpoints.depositSave, data: depositInput.toFormData());
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

  Future<BaseResponse> depositSold(int deposit_id) async {
    try {
      var response =
      await _service.post(Endpoints.depositSold, data: FormData.fromMap({
        'deposit_id': deposit_id
      }));
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

  Future<DepositDataResponse> depositData() async {
    try {
      var response =
      await _service.get(Endpoints.depositsData);
      DepositDataResponse depositDataResponse = await compute(depositDataResponseFromJson, response.data);
      print('Response --- $response');
      return depositDataResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

}