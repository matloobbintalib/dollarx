import '../models/referral_response.dart';

enum ReferralStatus {
  initial,
  loading,
  success,
  error,
}

class ReferralState {

  final ReferralStatus referralStatus;
  final ReferralModel? referralModel;
  final String message;
  final List<LevelReferral> levelReferrals;

  ReferralState( {required this.referralStatus,required this.referralModel,required this.message, required this.levelReferrals, });

  factory ReferralState.Initial(){
    return ReferralState(referralStatus: ReferralStatus.initial, referralModel : null, message: "", levelReferrals: [], );
  }



  ReferralState copyWith({
    ReferralStatus? referralStatus,
    ReferralModel? referralModel,
    String? message,
    List<LevelReferral>? levelReferrals
  }) {
    return ReferralState(
      referralStatus: referralStatus ?? this.referralStatus,
      referralModel: referralModel ?? this.referralModel,
      message: message ?? this.message,
      levelReferrals: levelReferrals ?? this.levelReferrals,
    );
  }
}
