import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/user_model.dart';
import '../repository/user_account_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required UserAccountRepository userAccountRepository})
      : _userAccountRepository = userAccountRepository,
        super(UserState.initial());

  final UserAccountRepository _userAccountRepository;

  void loadUser() {
    UserModel userModel = _userAccountRepository.getUserFromDb();
    emit(state.copyWith(userModel: userModel, userStatus: UserStatus.success));
  }

  Future<void> logout() async {
    emit(state.copyWith(userStatus: UserStatus.loginOut));
    await Future.delayed(Duration(seconds: 2));
    await _userAccountRepository.logout();
    emit(state.copyWith(
        userStatus: UserStatus.success, userModel: UserModel.empty));
  }
}
