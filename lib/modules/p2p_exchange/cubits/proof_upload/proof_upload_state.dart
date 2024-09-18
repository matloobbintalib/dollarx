
enum ProofUploadStatus {
  initial,
  loading,
  success,
  error,
}

class ProofUploadState {

  final ProofUploadStatus proofUploadStatus;
  final String message;

  ProofUploadState( {required this.proofUploadStatus,required this.message });

  factory ProofUploadState.Initial(){
    return ProofUploadState(proofUploadStatus: ProofUploadStatus.initial,  message: "" );
  }



  ProofUploadState copyWith({
    ProofUploadStatus? proofUploadStatus,
    String? message,
  }) {
    return ProofUploadState(
      proofUploadStatus: proofUploadStatus ?? this.proofUploadStatus,
      message: message ?? this.message,
    );
  }
}
