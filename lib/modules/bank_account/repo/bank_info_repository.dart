





import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/bank_account/models/bank_info_input.dart';
import 'package:dollarax/modules/investment_plan/models/investment_plan_response.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';

class BankInfoRepository {
  final DioClient _service = sl<DioClient>();

  final _log = logger(BankInfoRepository);

  Future<BaseResponse> addBankInfo(BankInfoInput bankInfoInput) async {
    try {
      var response =
      await _service.post(Endpoints.updateBankInfo, data: bankInfoInput.toFormData());
      print('Response --- ${response.data}');
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

}