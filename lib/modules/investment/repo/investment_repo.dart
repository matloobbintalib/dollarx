



import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';
import '../models/investment_response.dart';

class InvestmentRepository{
  final DioClient _service = sl<DioClient>();

  final _log = logger(InvestmentRepository);

  Future<InvestmentResponse> investmentDashboard() async {
    try {
      var response =
      await _service.get(Endpoints.investmentDashboard);
      print('Response --- ${response.data}');
      InvestmentResponse investmentResponse = await compute(investmentResponseFromJson, response.data);
      print('Response --- $response');
      return investmentResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

}