import 'package:dollarax/modules/trade/models/btc_to_usdt_response.dart';
import 'package:dollarax/modules/trade/models/graph_rate_response.dart';

enum BtcToUsdtStatus {
  initial,
  loading,
  success,
  error,
}

class BtcToUsdtState {

  final BtcToUsdtStatus btcToUsdtStatus;
  final List<BtcToUsdtGraph> btcToUsdtList;
  final String message;

  BtcToUsdtState( {required this.btcToUsdtStatus,required this.btcToUsdtList,required this.message });

  factory BtcToUsdtState.Initial(){
    return BtcToUsdtState(btcToUsdtStatus: BtcToUsdtStatus.initial, btcToUsdtList : [], message: "" );
  }



  BtcToUsdtState copyWith({
    BtcToUsdtStatus? btcToUsdtStatus,
    List<BtcToUsdtGraph>? btcToUsdtList,
    String? message,
  }) {
    return BtcToUsdtState(
      btcToUsdtStatus: btcToUsdtStatus ?? this.btcToUsdtStatus,
      btcToUsdtList: btcToUsdtList ?? this.btcToUsdtList,
      message: message ?? this.message,
    );
  }
}
