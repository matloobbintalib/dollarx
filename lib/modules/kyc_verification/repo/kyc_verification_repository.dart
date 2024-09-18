

import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/kyc_verification/models/country_list_response.dart';
import 'package:dollarax/modules/kyc_verification/models/kyc_verification_input.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';

class KycVerificationRepository{
  final DioClient _dioClient;
  final _log = logger(KycVerificationRepository);
  KycVerificationRepository( {
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  Future<BaseResponse> kycVerification( KycVerificationInput kycVerificationInput) async {
    try {
      print("Request--${kycVerificationInput.toJson()}");
      var response =
      await _dioClient.post(Endpoints.updateKycData, data: kycVerificationInput.toFormData());
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      return baseResponse;
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

  Future<CountryListResponse> getCountriesList() async {
    try {
      var response =
      await _dioClient.get(Endpoints.getCountries);
      CountryListResponse countryListResponse = CountryListResponse.fromJson(response.data);
      return countryListResponse;
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