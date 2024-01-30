

import '../../models/deposit_history_response.dart';

enum DepositHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class DepositHistoryState {
  final DepositHistoryStatus depositHistoryStatus;
  final List<DepositHistoryModel> depositHistoryList;
  final String message;

  DepositHistoryState(
      {required this.depositHistoryStatus,
        required this.depositHistoryList,
        required this.message});

  factory DepositHistoryState.Initial() {
    return DepositHistoryState(
        depositHistoryStatus: DepositHistoryStatus.initial,
        depositHistoryList: [],
        message: "");
  }

  DepositHistoryState copyWith({
    DepositHistoryStatus? depositHistoryStatus,
    List<DepositHistoryModel>? depositHistoryList,
    String? message,
  }) {
    return DepositHistoryState(
      depositHistoryStatus: depositHistoryStatus ?? this.depositHistoryStatus,
      depositHistoryList: depositHistoryList ?? this.depositHistoryList,
      message: message ?? this.message,
    );
  }
}

