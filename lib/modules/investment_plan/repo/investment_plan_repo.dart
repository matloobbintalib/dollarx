





import 'package:dio/dio.dart';
import 'package:dollarax/modules/investment_plan/models/investment_plan_response.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';

class InvestmentPlanRepository {
  final DioClient _service = sl<DioClient>();

  final _log = logger(InvestmentPlanRepository);

  Future<InvestmentPlansResponse> investmentPlans() async {
    try {
      var response =
      await _service.get(Endpoints.investmentPlans);
      print('Response --- ${response.data}');
      InvestmentPlansResponse investmentResponse = await compute(investmentPlansResponseFromJson, response.data);
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