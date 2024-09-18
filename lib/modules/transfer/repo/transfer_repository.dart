

import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/transfer/models/transfer_input.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';

class TransferRepository{
  final DioClient _dioClient;
  final _log = logger(TransferRepository);
  TransferRepository( {
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  Future<BaseResponse> fundTransfer( TransferInput transferInput) async {
    try {
      print("Request--${transferInput.toJson()}");
      var response =
      await _dioClient.post(Endpoints.fundTransferPost, data: transferInput.toFormData());
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