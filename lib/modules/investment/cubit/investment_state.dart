import 'package:dollarax/modules/investment/models/investment_response.dart';

enum InvestmentStatus {
  initial,
  loading,
  success,
  error,
}

class InvestmentState {
  final InvestmentStatus investmentStatus;
  final InvestmentModel? investmentModel;
  final String message;

  InvestmentState(
      {required this.investmentStatus,
      required this.investmentModel,
      required this.message});

  factory InvestmentState.Initial() {
    return InvestmentState(
        investmentStatus: InvestmentStatus.initial,
        investmentModel: null,
        message: "");
  }

  InvestmentState copyWith({
    InvestmentStatus? investmentStatus,
    InvestmentModel? investmentModel,
    String? message,
  }) {
    return InvestmentState(
      investmentStatus: investmentStatus ?? this.investmentStatus,
      investmentModel: investmentModel ?? this.investmentModel,
      message: message ?? this.message,
    );
  }
}
