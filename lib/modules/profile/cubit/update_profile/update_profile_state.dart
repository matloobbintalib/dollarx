import '../../../user/models/user_model.dart';

enum UpdateProfileStatus {
  none,
  loading,
  success,
  failure,
}

class UpdateProfileState {
  final UpdateProfileStatus updateProfileStatus;
  final String message;

  UpdateProfileState({
    required this.updateProfileStatus,
    this.message = '',
  });

  factory UpdateProfileState.initial() {
    return UpdateProfileState(
        updateProfileStatus: UpdateProfileStatus.none,
        message: '',);
  }

  UpdateProfileState copyWith({
    UpdateProfileStatus? updateProfileStatus,
    String? message,
  }) {
    return UpdateProfileState(
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      message: message ?? this.message,
    );
  }
}
