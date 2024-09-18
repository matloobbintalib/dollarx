import '../../../constants/keys.dart';
import '../../../core/security/secured_auth_storage.dart';
import '../../../core/storage_service/storage_service.dart';
import '../../../utils/logger/logger.dart';

class SessionRepository {
  final StorageService _storageService;
  final AuthSecuredStorage _authSecuredStorage;

  final _log = logger(SessionRepository);

  SessionRepository(
      {required StorageService storageService,
      required AuthSecuredStorage authSecuredStorage})
      : _authSecuredStorage = authSecuredStorage,
        _storageService = storageService;

  Future<void> setLoggedIn(bool value) async {
    await _storageService.setBool(StorageKeys.isLoggedIn, value);
    _log.i('setLoggedIn $value');
  }

  bool isLoggedIn() {
    bool isLoggedIn = _storageService.getBool(StorageKeys.isLoggedIn);
    _log.i('isLoggedIn: $isLoggedIn');
    return isLoggedIn;
  }

  Future<void> setToken(String token) async {
    await _authSecuredStorage.writeToken(token: token);
    _log.i('token set with value $token');
  }

  Future<String> getToken() async {
    return await _authSecuredStorage.readToken();
  }

  Future<void> removeToken() async {
    await _authSecuredStorage.removeToken();
    _log.i('token removed');
  }

  Future<void> setTradeBalance(String value) async {
    await _authSecuredStorage.writeTradeBalance(tradeBalance: value);
  }

  Future<void> setTradeROI(String value) async {
    await _authSecuredStorage.writeTradeROI(tradeROI: value);
  }

  Future<String> getTradeBalance() async {
    return await _authSecuredStorage.readTradeBalance();
  }

  Future<String> getTradeROI() async {
    return await _authSecuredStorage.readTradeROI();
  }

  Future<void> removeTradeBalance() async {
    await _authSecuredStorage.removeTradeBalance();
  }

  Future<void> removeTradeROI() async {
    await _authSecuredStorage.removeTradeROI();
  }
}
