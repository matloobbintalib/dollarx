

import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/exchange/models/exchange_input.dart';
import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';

class ExchangeRepository{
  final DioClient _dioClient;
  final _log = logger(ExchangeRepository);
  ExchangeRepository( {
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  Future<BaseResponse> buySellCoins( ExchangeInput exchangeInput) async {
    try {
      print("Request--${exchangeInput.toJson()}");
      var response =
      await _dioClient.post(Endpoints.buySellCoinsPost, data: exchangeInput.toFormData());
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