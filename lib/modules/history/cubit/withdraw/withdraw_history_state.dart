import '../../models/withdraw_history_response.dart';

enum WithdrawHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class WithdrawHistoryState {
  final WithdrawHistoryStatus withdrawHistoryStatus;
  final List<WithdrawHistoryModel> withdrawHistoryList;
  final String message;

  WithdrawHistoryState(
      {required this.withdrawHistoryStatus,
        required this.withdrawHistoryList,
        required this.message});

  factory WithdrawHistoryState.Initial() {
    return WithdrawHistoryState(
        withdrawHistoryStatus: WithdrawHistoryStatus.initial,
        withdrawHistoryList: [],
        message: "");
  }

  WithdrawHistoryState copyWith({
    WithdrawHistoryStatus? withdrawHistoryStatus,
    List<WithdrawHistoryModel>? withdrawHistoryList,
    String? message,
  }) {
    return WithdrawHistoryState(
      withdrawHistoryStatus: withdrawHistoryStatus ?? this.withdrawHistoryStatus,
      withdrawHistoryList: withdrawHistoryList ?? this.withdrawHistoryList,
      message: message ?? this.message,
    );
  }
}

