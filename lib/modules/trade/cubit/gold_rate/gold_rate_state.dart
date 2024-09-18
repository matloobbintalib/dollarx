

import 'package:dollarax/modules/trade/models/latest_gold_rate_response.dart';

enum GoldRateStatus {
  initial,
  loading,
  success,
  error,
}

class GoldRateState {
  final GoldRateStatus goldRateStatus;
  final GoldLatestRateModel? goldLatestRateModel;
  final String message;

  GoldRateState({required this.goldRateStatus, required this.message, required this.goldLatestRateModel});

  factory GoldRateState.Initial(){
    return GoldRateState(goldRateStatus: GoldRateStatus.initial, message: "", goldLatestRateModel: null);
  }


  GoldRateState copyWith({
    GoldRateStatus? goldRateStatus,
    GoldLatestRateModel? goldLatestRateModel,
    String? message,
  }) {
    return GoldRateState(
      goldRateStatus: goldRateStatus ?? this.goldRateStatus,
      goldLatestRateModel: goldLatestRateModel?? this.goldLatestRateModel,
      message: message ?? this.message,
    );
  }
}
