

import '../../models/profit_history_response.dart';

enum ProfitHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class ProfitHistoryState {
  final ProfitHistoryStatus profitHistoryStatus;
  final List<ProfitHistoryModel> profitHistoryList;
  final String message;

  ProfitHistoryState(
      {required this.profitHistoryStatus,
        required this.profitHistoryList,
        required this.message});

  factory ProfitHistoryState.Initial() {
    return ProfitHistoryState(
        profitHistoryStatus: ProfitHistoryStatus.initial,
        profitHistoryList: [],
        message: "");
  }

  ProfitHistoryState copyWith({
    ProfitHistoryStatus? profitHistoryStatus,
    List<ProfitHistoryModel>? profitHistoryList,
    String? message,
  }) {
    return ProfitHistoryState(
      profitHistoryStatus: profitHistoryStatus ?? this.profitHistoryStatus,
      profitHistoryList: profitHistoryList ?? this.profitHistoryList,
      message: message ?? this.message,
    );
  }
}

