
import 'package:dollarx/modules/home/models/dashoboard_data_response.dart';


enum DashBoardRefreshStatus {
  initial,
  loading,
  success,
  error,
}

class DashBoardRefreshState {
  final DashBoardRefreshStatus dashBoardStatus;
  final DashboardDataModel? dashboardModel;
  final String message;

  DashBoardRefreshState({
    required this.dashBoardStatus,
    required this.dashboardModel,
    required this.message,
  });

  factory DashBoardRefreshState.initial() {
    return DashBoardRefreshState(
      dashBoardStatus: DashBoardRefreshStatus.initial,
      dashboardModel: null,
      message: '',
    );
  }


  DashBoardRefreshState copyWith({
    DashBoardRefreshStatus? dashBoardStatus,
    DashboardDataModel? dashboardModel,
    String? message,
  }) {
    return DashBoardRefreshState(
      dashBoardStatus: dashBoardStatus ?? this.dashBoardStatus,
      dashboardModel: dashboardModel ?? this.dashboardModel,
      message: message ?? this.message,
    );
  }
}
