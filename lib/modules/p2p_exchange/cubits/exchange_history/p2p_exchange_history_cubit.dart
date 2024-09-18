import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/repo/p2p_repository.dart';
import '../../../../../core/exceptions/api_error.dart';

class P2PExchangeHistoryCubit extends Cubit<P2pExchangeHistoryState> {
  final P2PRepository _repository;

  P2PExchangeHistoryCubit(this._repository) : super(P2pExchangeHistoryState.Initial());


  Future<void> p2pBuyExchangeHistory({String? currency}) async {
    emit(state.copyWith(p2pExchangeStatus: P2PExchangeHistoryStatus.loading));
    try {
      P2PExchangeHistoryResponse response = await _repository.p2pBuyExchangeHistory(currency: currency);
      if (response.status == 200) {
        emit(state.copyWith(
            p2pExchangeStatus: P2PExchangeHistoryStatus.success,
            p2pExchangeList: response.data,
            message: response.message));
      } else {
        emit(state.copyWith(
            p2pExchangeStatus: P2PExchangeHistoryStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          p2pExchangeStatus: P2PExchangeHistoryStatus.error, message: e.message));
    }
  }
  Future<void> p2pSellExchangeHistory({String? currency}) async {
    emit(state.copyWith(p2pExchangeStatus: P2PExchangeHistoryStatus.loading));
    try {
      P2PExchangeHistoryResponse response = await _repository.p2pSellExchangeHistory(currency: currency);
      if (response.status == 200) {
        emit(state.copyWith(
            p2pExchangeStatus: P2PExchangeHistoryStatus.success,
            p2pSellExchangeList: response.data,
            message: response.message));
      } else {
        emit(state.copyWith(
            p2pExchangeStatus: P2PExchangeHistoryStatus.error,
            message: response.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          p2pExchangeStatus: P2PExchangeHistoryStatus.error, message: e.message));
    }
  }
}
