import 'package:bloc/bloc.dart';
import '../../../../core/exceptions/api_error.dart';
import '../models/investment_plan_response.dart';
import '../repo/investment_plan_repo.dart';
import 'investment_plan_state.dart';

class InvestmentPlanCubit extends Cubit<InvestmentPlanState> {
  final InvestmentPlanRepository _repository;

  InvestmentPlanCubit(this._repository) : super(InvestmentPlanState.Initial());

  Future<void> investmentPlans() async {
    emit(state.copyWith(investmentPlanStatus: InvestmentPlanStatus.loading));
    try {
      InvestmentPlansResponse investmentPlansResponse =
      await _repository.investmentPlans();
      if (investmentPlansResponse.status == 200) {
        emit(state.copyWith(
            investmentPlanStatus: InvestmentPlanStatus.success,
            investmentPlans: investmentPlansResponse.data,
            message: investmentPlansResponse.message));
      } else {
        emit(state.copyWith(
            investmentPlanStatus: InvestmentPlanStatus.error,
            message: investmentPlansResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          investmentPlanStatus: InvestmentPlanStatus.error, message: e.message));
    }
  }
}
