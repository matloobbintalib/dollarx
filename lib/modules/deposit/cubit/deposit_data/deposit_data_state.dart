

import 'package:dollarax/modules/deposit/models/deposit_data_response.dart';

enum DepositDataStatus {
  initial,
  loading,
  success,
  error,
}

class DepositDataState {

  final DepositDataStatus depositDataStatus;
  final DepositModel? depositModel;
  final String message;

  DepositDataState( {required this.depositDataStatus,required this.depositModel,required this.message});

  factory DepositDataState.Initial(){
    return DepositDataState(depositDataStatus: DepositDataStatus.initial, depositModel : null, message: "");
  }



  DepositDataState copyWith({
    DepositDataStatus? depositDataStatus,
    DepositModel? depositModel,
    String? message,
  }) {
    return DepositDataState(
      depositDataStatus: depositDataStatus ?? this.depositDataStatus,
      depositModel: depositModel ?? this.depositModel,
      message: message ?? this.message,
    );
  }
}
