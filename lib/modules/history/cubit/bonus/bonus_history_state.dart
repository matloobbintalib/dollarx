

import '../../models/bonus_history_response.dart';

enum BonusHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class BonusHistoryState {
  final BonusHistoryStatus bonusHistoryStatus;
  final List<BonusHistoryModel> bonusHistoryList;
  final String message;

  BonusHistoryState(
      {required this.bonusHistoryStatus,
        required this.bonusHistoryList,
        required this.message});

  factory BonusHistoryState.Initial() {
    return BonusHistoryState(
        bonusHistoryStatus: BonusHistoryStatus.initial,
        bonusHistoryList: [],
        message: "");
  }

  BonusHistoryState copyWith({
    BonusHistoryStatus? bonusHistoryStatus,
    List<BonusHistoryModel>? bonusHistoryList,
    String? message,
  }) {
    return BonusHistoryState(
      bonusHistoryStatus: bonusHistoryStatus ?? this.bonusHistoryStatus,
      bonusHistoryList: bonusHistoryList ?? this.bonusHistoryList,
      message: message ?? this.message,
    );
  }
}

