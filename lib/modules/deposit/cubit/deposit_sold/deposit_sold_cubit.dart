


import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dollarx/modules/authentication/models/base_response.dart';

import '../../../../../../core/exceptions/api_error.dart';
import '../../repo/deposit_repository.dart';
import 'deposit_sold_state.dart';


class DepositSoldCubit extends Cubit<DepositSoldState> {
  DepositSoldCubit(this._lotRepository) : super(DepositSoldState.Initial());

  final DepositRepository _lotRepository;

  Future<void> depositSave(int depositId) async {
    MultipartFile? image ;
    emit(state.copyWith(depositSoldStatus: DepositSoldStatus.loading));
    try {
      BaseResponse baseResponse = await _lotRepository.depositSold(depositId);
      if (baseResponse.status == 200) {
        emit(state.copyWith(depositSoldStatus: DepositSoldStatus.success, message: baseResponse.message));
      } else {
        emit(state.copyWith(
            depositSoldStatus: DepositSoldStatus.error,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          depositSoldStatus: DepositSoldStatus.error, message: e.message));
    }
  }
  
}
