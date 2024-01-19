import 'package:bloc/bloc.dart';
import 'package:dollarx/modules/home/repo/home_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/exceptions/api_error.dart';
import '../../authentication/models/auth_response.dart';
import '../models/dashoboard_data_response.dart';
import 'dashboard_refresh_state.dart';

class DashBoardRefreshCubit extends Cubit<DashBoardRefreshState> {
  final HomeRepoRepository _repository;

  DashBoardRefreshCubit(this._repository)
      : super(DashBoardRefreshState.initial());

  Future<void> dashBoardRefresh() async {
    emit(state.copyWith(dashBoardStatus: DashBoardRefreshStatus.loading));
    try {
      DashboardDataResponse dashboardDataResponse =
          await _repository.dashBoardRefresh();
      if (dashboardDataResponse.status == 200) {
        emit(state.copyWith(
            dashBoardStatus: DashBoardRefreshStatus.success,
            dashboardModel: dashboardDataResponse.data,
            message: dashboardDataResponse.message));
      } else {
        emit(state.copyWith(
            dashBoardStatus: DashBoardRefreshStatus.error,
            message: dashboardDataResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          dashBoardStatus: DashBoardRefreshStatus.error, message: e.message));
    }
  }
}
