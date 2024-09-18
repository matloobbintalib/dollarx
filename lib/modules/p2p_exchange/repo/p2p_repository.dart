import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/countries_list_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/exchange_rate_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_approved_exchange_input.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_proof_upload_input.dart';
import 'package:dollarax/modules/p2p_exchange/models/save_exchange_input.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';

class P2PRepository {
  final DioClient _service = sl<DioClient>();

  final _log = logger(P2PRepository);

  Future<CountriesListResponse> getAllCountries() async {
    try {
      var response = await _service.get(Endpoints.getCountriesList);
      print('Response --- ${response.data}');
      return CountriesListResponse.fromJson(response.data);
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

  Future<P2PExchangeHistoryResponse> p2pBuyExchangeHistory({String? currency}) async {
    try {
      var response = await _service.post(Endpoints.p2pBuyExchangeHistory,data: FormData.fromMap(
          {'currency': currency}));
      print('Response --- ${response.data}');
      return P2PExchangeHistoryResponse.fromJson(response.data);
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
 Future<P2PExchangeHistoryResponse> p2pSellExchangeHistory({String? currency}) async {
    try {
      var response = await _service.get(Endpoints.p2pSellExchangeHistory,data: FormData.fromMap(
          {'currency': currency}));
      print('Response --- ${response.data}');
      return P2PExchangeHistoryResponse.fromJson(response.data);
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

  Future<ExchangeRateResponse> getExchangeRate(
      String sellCurrency, String buyCurrency,String type) async {
    try {
      print('Request --- ${sellCurrency} - ${buyCurrency} - ${type}');
      var response = await _service.post(Endpoints.getExchangeRate,
          data: FormData.fromMap(
              {'sell_currency': sellCurrency, 'buy_currency': buyCurrency,'p2p_type':type}));
      print('Response --- ${response.data}');
      return ExchangeRateResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    }on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<BaseResponse> saveExchange(SaveExchangeInput input) async {
    try {
      print('Response --- ${input.toJson()}');
      var response = await _service.post(Endpoints.saveP2PNewBuy,
          data: input.toFormData());
      print('Response --- ${response.data}');
      return BaseResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    }on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
  Future<BaseResponse> p2pHoldBuy(int id) async {
    try {
      var response = await _service.post(Endpoints.p2pHoldBuy,
          data: FormData.fromMap({
            'p2p_id': id,
          }));
      print('Response --- ${response.data}');
      return BaseResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    }on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<bool> p2PRefreshHold(int id) async {
    try {
      var response = await _service.post(Endpoints.p2PRefreshHold,
          data: FormData.fromMap({
            'p2p_id': id,
          }));
      print('Response --- ${response.data}');
      if(response.data["success"] == "true"){
        return true;
      }else{
         return false;
      }
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    }on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<BaseResponse> p2pHoldSell(int id) async {
    try {
      var response = await _service.post(Endpoints.p2pHoldSell,
          data: FormData.fromMap({
            'p2p_id': id,
          }));
      print('Response --- ${response.data}');
      return BaseResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    }on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<BaseResponse> p2pBuyProofUpload(P2pProofUploadInput input) async {
    try {
      var response = await _service.post(Endpoints.p2pBuyProofUpload,
          data: input.toFormData());
      print('Response --- ${response.data}');
      return BaseResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    }on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
  Future<BaseResponse> p2pSellProofUpload(P2pProofUploadInput input) async {
    try {
      var response = await _service.post(Endpoints.p2pSellProofUpload,
          data: input.toFormData());
      print('Response --- ${response.data}');
      return BaseResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    }on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<BaseResponse> p2pApprovedSellExchange(P2pApprovedExchangeInput input) async {
    try {
      var response = await _service.post(Endpoints.p2pApprovedSellExchange,
          data: input.toFormData());
      print('Response --- ${response.data}');
      return BaseResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    }on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
  Future<BaseResponse> p2pApprovedBuyExchange(P2pApprovedExchangeInput input) async {
    try {
      var response = await _service.post(Endpoints.p2pApprovedBuyExchange,
          data: input.toFormData());
      print('Response --- ${response.data}');
      return BaseResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    }on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
}
