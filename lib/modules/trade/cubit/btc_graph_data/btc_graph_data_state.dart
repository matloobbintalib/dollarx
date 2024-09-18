import 'package:dollarax/modules/trade/models/graph_rate_response.dart';

enum BtcGraphDataStatus {
  initial,
  loading,
  success,
  error,
}

class BtcGraphDataState {

  final BtcGraphDataStatus btcGraphDataStatus;
  final List<BtcGraphModel> btcGraphDataList;
  final String message;

  BtcGraphDataState( {required this.btcGraphDataStatus,required this.btcGraphDataList,required this.message });

  factory BtcGraphDataState.Initial(){
    return BtcGraphDataState(btcGraphDataStatus: BtcGraphDataStatus.initial, btcGraphDataList : [], message: "" );
  }



  BtcGraphDataState copyWith({
    BtcGraphDataStatus? btcGraphDataStatus,
    List<BtcGraphModel>? btcGraphDataList,
    String? message,
  }) {
    return BtcGraphDataState(
      btcGraphDataStatus: btcGraphDataStatus ?? this.btcGraphDataStatus,
      btcGraphDataList: btcGraphDataList ?? this.btcGraphDataList,
      message: message ?? this.message,
    );
  }
}
