

import 'package:dio/dio.dart';
import 'package:dollarx/modules/webpage/models/content_page_response.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';

class ContentPageRepository{
  final DioClient _dioClient;
  final _log = logger(ContentPageRepository);
  ContentPageRepository( {
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  Future<ContentPageResponse> getContentPages( ) async {
    try {
      var response =
      await _dioClient.get(Endpoints.allPagesContent);
      print('Response--${response.data}');
      ContentPageResponse contentPageResponse = ContentPageResponse.fromJson(response.data);
      print('Response--${contentPageResponse.message}');
      return contentPageResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
}