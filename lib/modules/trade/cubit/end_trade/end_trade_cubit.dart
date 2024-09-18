import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/bank_account/cubit/add_bank_info_state.dart';
import 'package:dollarax/modules/bank_account/models/bank_info_input.dart';
import 'package:dollarax/modules/bank_account/repo/bank_info_repository.dart';
import 'package:dollarax/modules/trade/cubit/end_trade/end_trade_state.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import '../../../../../../core/exceptions/api_error.dart';


class EndTradeCubit extends Cubit<EndTradeState> {
  EndTradeCubit(this._repository) : super(EndTradeState.Initial());

  final TradeRepository _repository;

  Future<void> endCurrentTrade() async {
    emit(state.copyWith(endTradeStatus: EndTradeStatus.loading));
    try {
      BaseResponse baseResponse = await _repository.endCurrentTrade();
      if (baseResponse.status == 200) {
        emit(state.copyWith(endTradeStatus: EndTradeStatus.success, message: baseResponse.message));
      } else {
        emit(state.copyWith(
            endTradeStatus: EndTradeStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          endTradeStatus: EndTradeStatus.error, message: e.message));
    }
  }
}