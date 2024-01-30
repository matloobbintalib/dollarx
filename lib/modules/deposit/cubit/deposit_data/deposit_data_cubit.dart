import 'package:bloc/bloc.dart';
import 'package:dollarx/modules/deposit/models/deposit_data_response.dart';
import 'package:dollarx/modules/deposit/repo/deposit_repository.dart';

import '../../../../core/exceptions/api_error.dart';
import 'deposit_data_state.dart';

class DepositDataCubit extends Cubit<DepositDataState> {
  final DepositRepository _repository;

  DepositDataCubit(this._repository) : super(DepositDataState.Initial());

  Future<void> depositData() async {
    emit(state.copyWith(depositDataStatus: DepositDataStatus.loading));
    try {
      DepositDataResponse depositDataResponse = await _repository.depositData();
      if (depositDataResponse.status == 200) {
        emit(state.copyWith(
            depositDataStatus: DepositDataStatus.success,
            depositModel: depositDataResponse.data,
            message: depositDataResponse.message));
      } else {
        emit(state.copyWith(
            depositDataStatus: DepositDataStatus.error,
            message: depositDataResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          depositDataStatus: DepositDataStatus.error, message: e.message));
    }
  }
}
