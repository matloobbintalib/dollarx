import 'package:dollarx/modules/dashboard/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dollarx/modules/home/pages/home_page.dart';

import '../../config/routes/nav_router.dart';
import '../../constants/app_colors.dart';
import '../../constants/asset_paths.dart';
import '../../core/core.dart';
import '../authentication/pages/login_page.dart';
import '../user/cubits/user_cubit.dart';
import 'startup_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.black,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return BlocProvider(
      create: (context) => StartupCubit(
        dioClient: sl(),
        sessionRepository: sl(),
      )..init(),
      child: BlocListener<StartupCubit, StartupState>(
        listener: (context, state) {
          if (state.status == Status.authenticated) {
            context.read<UserCubit>().loadUser();
            NavRouter.pushReplacement(context, DashboardPage());
          } else if (state.status == Status.unauthenticated) {
            NavRouter.pushReplacement(context, LoginPage());
          }
        },
        child: Scaffold(
          body: Container(
            color: Colors.black,
            child: Center(
              child: Image.asset(
                AssetPaths.logoPng,
                width: 120,height: 120,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
