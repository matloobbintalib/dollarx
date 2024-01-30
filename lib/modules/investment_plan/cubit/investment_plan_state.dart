


import '../models/investment_plan_response.dart';

enum InvestmentPlanStatus {
  initial,
  loading,
  success,
  error,
}

class InvestmentPlanState {

  final InvestmentPlanStatus investmentPlanStatus;
  final List<InvestmentPlanModel> investmentPlans;
  final String message;

  InvestmentPlanState( {required this.investmentPlanStatus,required this.investmentPlans,required this.message});

  factory InvestmentPlanState.Initial(){
    return InvestmentPlanState(investmentPlanStatus: InvestmentPlanStatus.initial, investmentPlans : [], message: "");
  }



  InvestmentPlanState copyWith({
    InvestmentPlanStatus? investmentPlanStatus,
    List<InvestmentPlanModel>? investmentPlans,
    String? message,
  }) {
    return InvestmentPlanState(
      investmentPlanStatus: investmentPlanStatus ?? this.investmentPlanStatus,
      investmentPlans: investmentPlans ?? this.investmentPlans,
      message: message ?? this.message,
    );
  }
}
