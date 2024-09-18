
import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/repositories/session_repository.dart';
import 'package:dollarax/modules/home/models/dashoboard_data_response.dart';
import 'package:dollarax/modules/user/repository/user_account_repository.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/exceptions/api_error.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../utils/logger/logger.dart';

class HomeRepoRepository {
  final DioClient _dioClient = sl<DioClient>();
  final SessionRepository _sessionRepository = sl<SessionRepository>();
  final UserAccountRepository _userAccountRepository = sl<UserAccountRepository>();

  final _log = logger(HomeRepoRepository);

  Future<DashboardDataResponse> dashBoardRefresh() async {
    try {
      var response =
      await _dioClient.get(Endpoints.dashBoardRefresh);
      print("Response ${response.data}");
      DashboardDataResponse dashboardDataResponse = DashboardDataResponse.fromJson(response.data);
      await _userAccountRepository.saveUserInDb(dashboardDataResponse.data.user);
      await _sessionRepository.setTradeBalance(dashboardDataResponse.data.totalCopyTradeInvestmentUSD);
      await _sessionRepository.setTradeROI(dashboardDataResponse.data.copyTradeProfit);
      return dashboardDataResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    }catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
}
