import 'package:dollarx/modules/authentication/repositories/auth_repository.dart';
import 'package:dollarx/modules/authentication/repositories/session_repository.dart';
import 'package:dollarx/modules/deposit/repo/deposit_repository.dart';
import 'package:dollarx/modules/history/repo/history_repo.dart';
import 'package:dollarx/modules/home/repo/home_repo.dart';
import 'package:dollarx/modules/investment/repo/investment_repo.dart';
import 'package:dollarx/modules/referalls/repo/referral_repository.dart';
import 'package:dollarx/modules/user/repository/user_account_repository.dart';
import 'package:dollarx/modules/withdraw/repo/withdraw_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/environment.dart';
import '../../modules/investment_plan/repo/investment_plan_repo.dart';
import '../../modules/profile/repo/profile_repository.dart';
import '../../modules/webpage/repo/content_page_repository.dart';
import '../network/dio_client.dart';
import '../notifications/cloud_messaging_api.dart';
import '../notifications/local_notification_api.dart';
import '../security/secured_auth_storage.dart';
import '../storage_service/storage_service.dart';

final sl = GetIt.instance;

void setupLocator(Environment environment) async {
  // env
  sl.registerLazySingleton<Environment>(() => environment);

  // sp
  sl.registerSingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance());

  // modules
  sl.registerSingletonWithDependencies<StorageService>(
    () => StorageService(sharedPreferences: sl()),
    dependsOn: [SharedPreferences],
  );

  sl.registerLazySingleton<AuthSecuredStorage>(() => AuthSecuredStorage());
  sl.registerLazySingleton<DioClient>(() => DioClient(environment: sl()));

  // notifications
  sl.registerLazySingleton<CloudMessagingApi>(() => CloudMessagingApi());
  sl.registerLazySingleton<LocalNotificationsApi>(
      () => LocalNotificationsApi());

  // Repositories

  /// ************************************** Authentication **************************************

  // sl.registerLazySingleton<AuthUserRepository>(
  //       () => AuthUserRepository(
  //     storageService: sl<StorageService>(),
  //   ),
  // );

  sl.registerLazySingleton<SessionRepository>(
    () => SessionRepository(
      storageService: sl<StorageService>(),
      authSecuredStorage: sl<AuthSecuredStorage>(),
    ),
  );

  sl.registerLazySingleton<UserAccountRepository>(
    () => UserAccountRepository(
      storageService: sl<StorageService>(),
      sessionRepository: sl<SessionRepository>(),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      dioClient: sl(),
      userAccountRepository: sl(),
      sessionRepository: sl(),
    ),
  );
  sl.registerLazySingleton<DepositRepository>(
    () => DepositRepository(),
  );

  sl.registerLazySingleton<HomeRepoRepository>(
    () => HomeRepoRepository(),
  );

  sl.registerLazySingleton<WithdrawRepository>(
    () => WithdrawRepository(),
  );

  sl.registerLazySingleton<InvestmentRepository>(
    () => InvestmentRepository(),
  );

  sl.registerLazySingleton<InvestmentPlanRepository>(
    () => InvestmentPlanRepository(),
  );
  sl.registerLazySingleton<HistoryRepository>(
    () => HistoryRepository(),
  );

  sl.registerLazySingleton<ReferralRepository>(
    () => ReferralRepository(),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(dioClient: sl()),
  );
sl.registerLazySingleton<ContentPageRepository>(
    () => ContentPageRepository(dioClient: sl()),
  );

  /// ********************************************************************************************
}
