import 'package:dollarax/modules/wallet/models/wallet_details_response.dart';

enum WalletDetailsStatus {
  initial,
  loading,
  success,
  error,
}

class WalletDetailsState {

  final WalletDetailsStatus walletDetailsStatus;
  final WalletModel? walletModel;
  final String message;

  WalletDetailsState( {required this.walletDetailsStatus,required this.walletModel,required this.message });

  factory WalletDetailsState.Initial(){
    return WalletDetailsState(walletDetailsStatus: WalletDetailsStatus.initial, walletModel : null, message: "" );
  }



  WalletDetailsState copyWith({
    WalletDetailsStatus? walletDetailsStatus,
    WalletModel? walletModel,
    String? message,
  }) {
    return WalletDetailsState(
      walletDetailsStatus: walletDetailsStatus ?? this.walletDetailsStatus,
      walletModel: walletModel ?? this.walletModel,
      message: message ?? this.message,
    );
  }
}
