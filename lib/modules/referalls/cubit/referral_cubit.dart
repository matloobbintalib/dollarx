import 'package:bloc/bloc.dart';
import 'package:dollarax/modules/referalls/cubit/referral_state.dart';
import '../../../../core/exceptions/api_error.dart';
import '../models/referral_response.dart';
import '../repo/referral_repository.dart';

class ReferralCubit extends Cubit<ReferralState> {
  final ReferralRepository _repository;

  ReferralCubit(this._repository) : super(ReferralState.Initial());

  List<LevelReferral> levelReferrals = [];
  List<LevelReferral> filterRevelReferrals = [];

  Future<void> referralData() async {
    emit(state.copyWith(referralStatus: ReferralStatus.loading));
    try {
      ReferralResponse referralResponse = await _repository.referralData();
      if (referralResponse.status == 200) {
        levelReferrals.addAll(referralResponse.data.level1Referrals);
        emit(state.copyWith(
            referralStatus: ReferralStatus.success,
            referralModel: referralResponse.data,
            message: referralResponse.message,
            levelReferrals: levelReferrals));
      } else {
        emit(state.copyWith(
            referralStatus: ReferralStatus.error,
            message: referralResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          referralStatus: ReferralStatus.error, message: e.message));
    }
  }

  void setReferralList(List<LevelReferral> list) {
    levelReferrals = list;
    emit(state.copyWith(
        referralStatus: ReferralStatus.success,
        levelReferrals: levelReferrals));
  }

  void filterSearchResults(String query) {
    filterRevelReferrals = levelReferrals.where((item) => item.referralId
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();
    if(query.isNotEmpty){
      emit(state.copyWith(
          referralStatus: ReferralStatus.success,
          levelReferrals: filterRevelReferrals));
    }else{
      emit(state.copyWith(
          referralStatus: ReferralStatus.success,
          levelReferrals: levelReferrals));
    }
  }
}
