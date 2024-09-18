import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _kTokenKey = "token";
const _kTradeBalanceKey = "trade_balance";
const _kTradeROIKey = "trade_ROI";

class AuthSecuredStorage {
  final FlutterSecureStorage _storage;

  AuthSecuredStorage({
    FlutterSecureStorage? storage,
  }) : _storage = storage ?? FlutterSecureStorage();

  Future<void> writeToken({required String token}) async {
    await _storage.write(key: _kTokenKey, value: token);
  }

  Future<String> readToken() async {
    return await _storage.read(key: _kTokenKey) ?? 'empty-token';
  }

  Future<void> removeToken() async {
    await _storage.delete(key: _kTokenKey);
  }

  Future<void> writeTradeBalance({required String tradeBalance}) async {
    await _storage.write(key: _kTradeBalanceKey, value: tradeBalance);
  }

  Future<void> writeTradeROI({required String tradeROI}) async {
    await _storage.write(key: _kTradeROIKey, value: tradeROI);
  }

  Future<String> readTradeBalance() async {
    return await _storage.read(key: _kTradeBalanceKey) ?? 'empty-trade-balance';
  }

  Future<void> removeTradeBalance() async {
    await _storage.delete(key: _kTradeBalanceKey);
  }
  Future<String> readTradeROI() async {
    return await _storage.read(key: _kTradeROIKey) ?? 'empty-trade-roi';
  }

  Future<void> removeTradeROI() async {
    await _storage.delete(key: _kTradeROIKey);
  }
}
