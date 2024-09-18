import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/islamic_trade/models/end_islamic_trade_input.dart';
import 'package:dollarax/modules/islamic_trade/models/islamic_trade_history_response.dart';
import 'package:dollarax/modules/islamic_trade/models/islamic_trade_items_response.dart';
import 'package:dollarax/modules/islamic_trade/models/start_islamic_trade_input.dart';
import 'package:dollarax/modules/trade/models/active_trade_response.dart';
import 'package:dollarax/modules/trade/models/btc_to_usdt_input.dart';
import 'package:dollarax/modules/trade/models/btc_to_usdt_response.dart';
import 'package:dollarax/modules/trade/models/buy_sell_input.dart';
import 'package:dollarax/modules/trade/models/gold_trade_response.dart';
import 'package:dollarax/modules/trade/models/graph_input.dart';
import 'package:dollarax/modules/trade/models/graph_rate_response.dart';
import 'package:dollarax/modules/trade/models/latest_gold_rate_response.dart';
import 'package:dollarax/modules/trade/models/latest_trades_response.dart';
import 'package:dollarax/modules/trade/models/take_profit_stop_loss_response.dart';
import 'package:dollarax/modules/trade/models/trade_dashboard_response.dart';
import 'package:dollarax/modules/trade/models/trade_profit_loss_grapgh_response.dart';
import 'package:dollarax/modules/trade/models/trade_tpsl_input.dart';

import '../../../constants/api_endpoints.dart';
import '../../../core/exceptions/api_error.dart';
import '../../../core/network/dio_client.dart';
import '../../../utils/logger/logger.dart';

class TradeRepository {
  final DioClient _dioClient;
  final _log = logger(TradeRepository);

  TradeRepository({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  Future<TradeDashboardResponse> getTradeDashboardData() async {
    try {
      var response = await _dioClient.post(Endpoints.tradeDashboard);
      TradeDashboardResponse tradeDashboardResponse =
          TradeDashboardResponse.fromJson(response.data);
      return tradeDashboardResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<BaseResponse> startNewBuyTrade(BuySellInput buySellInput) async {
    try {
      print('request ${buySellInput.toJson()}');
      var response = await _dioClient.post(Endpoints.startNewBuyTrade,
          data: buySellInput.toFormData());
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

  Future<BaseResponse> startNewSellTrade(BuySellInput buySellInput) async {
    try {
      print('request ${buySellInput.toJson()}');
      var response = await _dioClient.post(Endpoints.startNewSellTrade,
          data: buySellInput.toFormData());
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

  Future<BaseResponse> endCurrentTrade() async {
    try {
      var response = await _dioClient.post(Endpoints.endCurrentTrade);
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

  Future<GraphRatesResponse> btcGraphRateData(GraphInput graphInput) async {
    try {
      var response = await _dioClient.post(Endpoints.btcGraphRates,
          data: graphInput.toFormData());
      GraphRatesResponse graphRatesResponse =
          GraphRatesResponse.fromJson(response.data);
      return graphRatesResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
Future<GoldTradeResponse> goldTradeData(GraphInput graphInput) async {
    try {
      var response = await _dioClient.post(Endpoints.graphRatesApi,
          data: graphInput.toFormData());
      GoldTradeResponse goldTradeResponse =
      GoldTradeResponse.fromJson(response.data);
      return goldTradeResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<BtcToUsdtGraphResponse> btcToUsdt(BtcToUsdtInput graphInput) async {
    try {
      var response = await _dioClient.post(Endpoints.btcNewGraphRates,
          data: graphInput.toFormData());
      BtcToUsdtGraphResponse graphRatesResponse =
          BtcToUsdtGraphResponse.fromJson(response.data);
      return graphRatesResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<ActiveTradeResponse> activeTrade() async {
    try {
      var response = await _dioClient.get(Endpoints.getActiveTrade);
      ActiveTradeResponse activeTradeResponse =
          ActiveTradeResponse.fromJson(response.data);
      return activeTradeResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<TradeTPSLResponse> updateTradesTPSL(TradeTPSLInput tradeTPSLInput) async {
    try {
      var response = await _dioClient.post(Endpoints.updateTradesTPSL, data: tradeTPSLInput.toFormData());
      TradeTPSLResponse tradeTPSLResponse =
          TradeTPSLResponse.fromJson(response.data);
      return tradeTPSLResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<LatestTradesResponse> latestTrades() async {
    try {
      var response = await _dioClient.get(Endpoints.latestTrades);
      LatestTradesResponse latestTradesResponse =
          LatestTradesResponse.fromJson(response.data);
      return latestTradesResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<TradeProfitLossGraphResponse> tradeProfitLossGraph(
      GraphInput graphInput) async {
    try {
      var response = await _dioClient.post(Endpoints.tradeProfitLossGraph,
          data: graphInput.toFormData());
      TradeProfitLossGraphResponse tradeProfitLossGraphResponse =
          TradeProfitLossGraphResponse.fromJson(response.data);
      return tradeProfitLossGraphResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
  Future<GoldLatestRateResponse> goldLatestRate() async {
    try {
      var response = await _dioClient.get(Endpoints.latestTradeRate);
      GoldLatestRateResponse goldLatestRateResponse =
      GoldLatestRateResponse.fromJson(response.data);
      return goldLatestRateResponse;
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }

  Future<IslamicTradItemsResponse> getIslamicTradeItems() async {
    try {
      var response = await _dioClient.get(Endpoints.getIslamicTradeItems);
      return IslamicTradItemsResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
  Future<IslamicTradeHistoryResponse> islamicTradesHistory() async {
    try {
      var response = await _dioClient.get(Endpoints.islamicTradesHistory);
      return IslamicTradeHistoryResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
  Future<BaseResponse> startIslamicTrade(StartIslamicTradeInput input) async {
    try {
      print('request ${input.toJson()}');
      var response = await _dioClient.post(Endpoints.startIslamicTrade, data: input.toFormData());
      return BaseResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
  Future<BaseResponse> endIslamicTrade(EndIslamicTradeInput input) async {
    try {
      var response = await _dioClient.post(Endpoints.closeIslamicTrade, data: input.toFormData());
      return BaseResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      _log.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } on TypeError catch (e) {
      _log.e(e.stackTrace);
      throw ApiError(message: '$e', code: 0);
    } catch (e) {
      _log.e(e);
      throw ApiError(message: '$e', code: 0);
    }
  }
}
