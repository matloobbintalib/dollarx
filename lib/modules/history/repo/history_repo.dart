import 'package:dio/dio.dart';
import 'package:dollarx/modules/history/models/bonus_history_response.dart';
import 'package:dollarx/modules/history/models/deposit_history_response.dart';
import 'package:dollarx/modules/history/models/profit_history_response.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';
import '../models/withdraw_history_response.dart';

class HistoryRepository {
  final DioClient _service = sl<DioClient>();

  final _log = logger(HistoryRepository);

  Future<DepositHistoryResponse> depositHistory() async {
    try {
      var response = await _service.get(Endpoints.depositsList);
      print('Response --- ${response.data}');
      DepositHistoryResponse depositHistoryResponse =
          await compute(depositHistoryResponseFromJson, response.data);
      print('Response --- $response');
      return depositHistoryResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<WithdrawHistoryResponse> withdrawHistory() async {
    try {
      var response = await _service.get(Endpoints.withdrawsList);
      print('Response --- ${response.data}');
      WithdrawHistoryResponse withdrawHistoryResponse =
      await compute(withdrawHistoryResponseFromJson, response.data);
      print('Response --- $response');
      return withdrawHistoryResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<ProfitHistoryResponse> profitHistory() async {
    try {
      var response = await _service.get(Endpoints.profitHistory);
      print('Response --- ${response.data}');
      ProfitHistoryResponse profitHistoryResponse =
      await compute(profitHistoryResponseFromJson, response.data);
      print('Response --- $response');
      return profitHistoryResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<BonusHistoryResponse> bonusHistory() async {
    try {
      var response = await _service.get(Endpoints.bonusHistory);
      print('Response --- ${response.data}');
      BonusHistoryResponse bonusHistoryResponse =
      await compute(bonusHistoryResponseFromJson, response.data);
      print('Response --- $response');
      return bonusHistoryResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
}
