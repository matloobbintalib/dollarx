import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/wallet/cubit/wallet_details_state.dart';
import 'package:dollarax/modules/wallet/models/wallet_details_response.dart';
import 'package:dollarax/modules/wallet/repo/wallet_repository.dart';
import '../../../../core/exceptions/api_error.dart';

class WalletDetailsCubit extends Cubit<WalletDetailsState> {
  final WalletRepository _repository;

  WalletDetailsCubit(this._repository) : super(WalletDetailsState.Initial());
  

  Future<void> walletDetailsData() async {
    emit(state.copyWith(walletDetailsStatus: WalletDetailsStatus.loading));
    try {
      WalletDetailsResponse walletDetailsResponse = await _repository.getWalletDetails();
      if (walletDetailsResponse.status == 200) {
        emit(state.copyWith(
            walletDetailsStatus: WalletDetailsStatus.success,
            walletModel: walletDetailsResponse.data,
            message: walletDetailsResponse.message));
      } else {
        emit(state.copyWith(
            walletDetailsStatus: WalletDetailsStatus.error,
            message: walletDetailsResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          walletDetailsStatus: WalletDetailsStatus.error, message: e.message));
    }
  }
}
