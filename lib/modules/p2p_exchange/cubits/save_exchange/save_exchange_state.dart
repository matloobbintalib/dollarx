
enum SaveExchangeStatus {
  initial,
  loading,
  success,
  error,
}

class SaveExchangeState {

  final SaveExchangeStatus saveExchangeStatus;
  final String message;

  SaveExchangeState( {required this.saveExchangeStatus,required this.message });

  factory SaveExchangeState.Initial(){
    return SaveExchangeState(saveExchangeStatus: SaveExchangeStatus.initial,  message: "" );
  }



  SaveExchangeState copyWith({
    SaveExchangeStatus? saveExchangeStatus,
    String? message,
  }) {
    return SaveExchangeState(
      saveExchangeStatus: saveExchangeStatus ?? this.saveExchangeStatus,
      message: message ?? this.message,
    );
  }
}
