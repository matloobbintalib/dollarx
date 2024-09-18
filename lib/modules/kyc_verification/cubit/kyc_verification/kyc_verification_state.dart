

enum KycVerificationStatus {
  initial,
  loading,
  success,
  error,
}

class KycVerificationState {
  final KycVerificationStatus kycVerificationStatus;
  final String message;

  KycVerificationState({required this.kycVerificationStatus, required this.message});

  factory KycVerificationState.Initial(){
    return KycVerificationState(kycVerificationStatus: KycVerificationStatus.initial, message: "");
  }


  KycVerificationState copyWith({
    KycVerificationStatus? kycVerificationStatus,
    String? message,
  }) {
    return KycVerificationState(
      kycVerificationStatus: kycVerificationStatus ?? this.kycVerificationStatus,
      message: message ?? this.message,
    );
  }
}
