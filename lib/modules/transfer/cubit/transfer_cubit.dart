import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/authentication/models/base_response.dart';
import 'package:dollarax/modules/transfer/models/transfer_input.dart';
import 'package:dollarax/modules/transfer/cubit/transfer_state.dart';
import 'package:dollarax/modules/transfer/repo/transfer_repository.dart';

import '../../../../core/exceptions/api_error.dart';

class TransferCubit extends Cubit<TransferState> {
  final TransferRepository _repository;

  TransferCubit(this._repository) : super(TransferState.initial());

  Future<void> fundTransfer(TransferInput transferInput) async {
    emit(state.copyWith(transferStatus: TransferStatus.loading));
    try {
      BaseResponse baseResponse =
      await _repository.fundTransfer(transferInput);
      if (baseResponse.status == 200) {
        emit(state.copyWith(
            transferStatus: TransferStatus.success,
            message: baseResponse.message));
      } else {
        emit(state.copyWith(
            transferStatus: TransferStatus.failure,
            message: baseResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          transferStatus: TransferStatus.failure, message: e.message));
    }
  }
}
