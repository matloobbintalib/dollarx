

import 'package:dollarax/modules/withdraw/models/withdraw_data_response.dart';

enum WithdrawDataStatus {
  initial,
  loading,
  success,
  error,
}

class WithdrawDataState {

  final WithdrawDataStatus withdrawDataStatus;
  final WithdrawModel? withdrawModel;
  final String message;

  WithdrawDataState( {required this.withdrawDataStatus,required this.withdrawModel,required this.message});

  factory WithdrawDataState.Initial(){
    return WithdrawDataState(withdrawDataStatus: WithdrawDataStatus.initial, withdrawModel : null, message: "");
  }



  WithdrawDataState copyWith({
    WithdrawDataStatus? withdrawDataStatus,
    WithdrawModel? withdrawModel,
    String? message,
  }) {
    return WithdrawDataState(
      withdrawDataStatus: withdrawDataStatus ?? this.withdrawDataStatus,
      withdrawModel: withdrawModel ?? this.withdrawModel,
      message: message ?? this.message,
    );
  }
}
