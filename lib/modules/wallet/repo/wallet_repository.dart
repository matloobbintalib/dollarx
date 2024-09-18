

import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/transfer/models/transfer_input.dart';
import 'package:dollarax/modules/wallet/models/wallet_details_response.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';

class WalletRepository{
  final DioClient _dioClient;
  final _log = logger(WalletRepository);
  WalletRepository( {
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  Future<WalletDetailsResponse> getWalletDetails() async {
    try {
      var response =
      await _dioClient.get(Endpoints.walletDetails);
      WalletDetailsResponse walletDetailsResponse = WalletDetailsResponse.fromJson(response.data);
      return walletDetailsResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
}