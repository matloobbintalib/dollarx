import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';


enum P2PExchangeHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class P2pExchangeHistoryState {

  final P2PExchangeHistoryStatus p2pExchangeStatus;
  final List<P2PExchangeModel> p2pExchangeList;
  final List<P2PExchangeModel> p2pSellExchangeList;
  final String message;

  P2pExchangeHistoryState( {required this.p2pExchangeStatus,required this.p2pExchangeList,required this.p2pSellExchangeList, required this.message });

  factory P2pExchangeHistoryState.Initial(){
    return P2pExchangeHistoryState(p2pExchangeStatus: P2PExchangeHistoryStatus.initial, p2pExchangeList : [], p2pSellExchangeList:[],message: "" );
  }



  P2pExchangeHistoryState copyWith({
    P2PExchangeHistoryStatus? p2pExchangeStatus,
    List<P2PExchangeModel>? p2pExchangeList,
    List<P2PExchangeModel>? p2pSellExchangeList,
    String? message,
  }) {
    return P2pExchangeHistoryState(
      p2pExchangeStatus: p2pExchangeStatus ?? this.p2pExchangeStatus,
      p2pExchangeList: p2pExchangeList ?? this.p2pExchangeList,
      p2pSellExchangeList: p2pSellExchangeList ?? this.p2pSellExchangeList,
      message: message ?? this.message,
    );
  }
}
