import 'package:dollarax/modules/authentication/repositories/auth_repository.dart';
import 'package:dollarax/modules/authentication/repositories/session_repository.dart';
import 'package:dollarax/modules/bank_account/repo/bank_info_repository.dart';
import 'package:dollarax/modules/deposit/repo/deposit_repository.dart';
import 'package:dollarax/modules/exchange/repo/exchange_repo.dart';
import 'package:dollarax/modules/history/repo/history_repo.dart';
import 'package:dollarax/modules/home/repo/home_repo.dart';
import 'package:dollarax/modules/investment/repo/investment_repo.dart';
import 'package:dollarax/modules/kyc_verification/repo/kyc_verification_repository.dart';
import 'package:dollarax/modules/p2p_exchange/repo/p2p_repository.dart';
import 'package:dollarax/modules/referalls/repo/referral_repository.dart';
import 'package:dollarax/modules/trade/repo/trade_repository.dart';
import 'package:dollarax/modules/transfer/repo/transfer_repository.dart';
import 'package:dollarax/modules/user/repository/user_account_repository.dart';
import 'package:dollarax/modules/wallet/repo/wallet_repository.dart';
import 'package:dollarax/modules/withdraw/repo/withdraw_repo.dart';
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

  sl.registerLazySingleton<KycVerificationRepository>(
    () => KycVerificationRepository(dioClient: sl()),
  );

  sl.registerLazySingleton<TransferRepository>(
        () => TransferRepository(dioClient: sl()),
  );

  sl.registerLazySingleton<WalletRepository>(
        () => WalletRepository(dioClient: sl()),
  );
  sl.registerLazySingleton<TradeRepository>(
        () => TradeRepository(dioClient: sl()),
  );
sl.registerLazySingleton<ExchangeRepository>(
        () => ExchangeRepository(dioClient: sl()),
  );

  sl.registerLazySingleton<BankInfoRepository>(
    () => BankInfoRepository(),
  );
  sl.registerLazySingleton<P2PRepository>(
    () => P2PRepository(),
  );

  /// ********************************************************************************************
}
