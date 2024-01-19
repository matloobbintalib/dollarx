part of 'user_cubit.dart';

enum UserStatus {
  initial,
  loading,
  loginOut,
  success,
  error,
}

class UserState extends Equatable {
  final UserStatus userStatus;
  final UserModel userModel;

  UserState({
    required this.userStatus,
    required this.userModel,
  });

  factory UserState.initial() {
    return UserState(
      userStatus: UserStatus.initial,
      userModel: UserModel.empty,
    );
  }

  UserState copyWith({UserStatus? userStatus, UserModel? userModel}) {
    return UserState(
      userModel: userModel ?? this.userModel,
      userStatus: userStatus ?? this.userStatus,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userModel, userStatus];
}
