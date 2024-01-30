
import 'package:dio/dio.dart';
import 'package:dollarx/modules/home/models/dashoboard_data_response.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/exceptions/api_error.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../utils/logger/logger.dart';

class HomeRepoRepository {
  final DioClient _dioClient = sl<DioClient>();

  final _log = logger(HomeRepoRepository);

  Future<DashboardDataResponse> dashBoardRefresh() async {
    try {
      var response =
      await _dioClient.get(Endpoints.dashBoardRefresh);
      print("Response ${response.data}");
      DashboardDataResponse dashboardDataResponse = DashboardDataResponse.fromJson(response.data);
      return dashboardDataResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
}
