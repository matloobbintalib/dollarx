import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../authentication/repositories/session_repository.dart';
import '../user/models/user_model.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit({
    required DioClient dioClient,
    required SessionRepository sessionRepository,
  })  : _dioClient = dioClient,
        _sessionRepository = sessionRepository,
        super(StartupState.initial());

  final DioClient _dioClient;
  final SessionRepository _sessionRepository;

  void init() async {
    await Future.delayed(Duration(seconds: 3));
    // emit(state.copyWith(status: Status.unauthenticated));

    bool isLoggedIn = await _sessionRepository.isLoggedIn();

    if (isLoggedIn) {
      String token = await _sessionRepository.getToken();
      print('Token --- ${token}');
      _dioClient.setToken(token);
      emit(state.copyWith(status: Status.authenticated));
    } else {
      emit(state.copyWith(status: Status.unauthenticated));
    }
  }
}
