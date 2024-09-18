import 'package:candlesticks/candlesticks.dart';
import 'package:dollarax/modules/trade/models/btc_to_usdt_response.dart';
import 'package:dollarax/modules/trade/models/gold_data_model.dart';
import 'package:dollarax/modules/trade/models/graph_rate_response.dart';

enum GoldLiveDataStatus {
  initial,
  loading,
  success,
  error,
}

class GoldLiveDataState {

  final GoldLiveDataStatus goldLiveDataStatus;
  final List<GoldDataModel> candles;
  final String message;

  GoldLiveDataState( {required this.goldLiveDataStatus,required this.candles,required this.message });

  factory GoldLiveDataState.Initial(){
    return GoldLiveDataState(goldLiveDataStatus: GoldLiveDataStatus.initial, candles : [], message: "" );
  }



  GoldLiveDataState copyWith({
    GoldLiveDataStatus? goldLiveDataStatus,
    List<GoldDataModel>? candles,
    String? message,
  }) {
    return GoldLiveDataState(
      goldLiveDataStatus: goldLiveDataStatus ?? this.goldLiveDataStatus,
      candles: candles ?? this.candles,
      message: message ?? this.message,
    );
  }
}
