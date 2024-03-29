import 'package:bloc/bloc.dart';
import 'package:dollarx/modules/deposit/models/deposit_data_response.dart';
import 'package:dollarx/modules/deposit/repo/deposit_repository.dart';
import 'package:dollarx/modules/home/repo/home_repo.dart';
import 'package:dollarx/modules/investment/repo/investment_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/exceptions/api_error.dart';
import '../models/investment_response.dart';
import 'investment_state.dart';

class InvestmentCubit extends Cubit<InvestmentState> {
  final InvestmentRepository _repository;

  InvestmentCubit(this._repository) : super(InvestmentState.Initial());

  Future<void> investmentDashboard() async {
    emit(state.copyWith(investmentStatus: InvestmentStatus.loading));
    try {
      InvestmentResponse investmentResponse =
          await _repository.investmentDashboard();
      if (investmentResponse.status == 200) {
        emit(state.copyWith(
            investmentStatus: InvestmentStatus.success,
            investmentModel: investmentResponse.data,
            message: investmentResponse.message));
      } else {
        emit(state.copyWith(
            investmentStatus: InvestmentStatus.error,
            message: investmentResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          investmentStatus: InvestmentStatus.error, message: e.message));
    }
  }
}
