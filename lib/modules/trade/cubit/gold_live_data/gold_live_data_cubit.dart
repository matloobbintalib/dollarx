import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/trade/cubit/gold_live_data/gold_live_data_state.dart';
import 'package:dollarax/modules/trade/models/gold_data_model.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import '../../../../../core/exceptions/api_error.dart';
import 'package:http/http.dart' as http;

class GoldLiveDataCubit extends Cubit<GoldLiveDataState> {

  GoldLiveDataCubit() : super(GoldLiveDataState.Initial());

  Future<void> goldLiveDataData(String date, String interval) async {
    emit(state.copyWith(goldLiveDataStatus: GoldLiveDataStatus.loading));
    try {
      final uri = Uri.parse("https://api.tiingo.com/tiingo/fx/xauusd/prices?startDate=${date}&resampleFreq=${interval}&token=44a5f88a3f5b4e91ec77e78603c5f84fe2942e23");
      final response = await http.get(uri);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        var list = (jsonDecode(response.body) as List<dynamic>)
            .map((e) => GoldDataModel.fromJson(e))
            .toList()
            .reversed
            .toList();
        emit(state.copyWith(
            goldLiveDataStatus: GoldLiveDataStatus.success,
            candles: list,));
      } else {
        emit(state.copyWith(
            goldLiveDataStatus: GoldLiveDataStatus.error,
            message: "Error fetching gold live data"));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          goldLiveDataStatus: GoldLiveDataStatus.error, message: e.message));
    }
  }
}
