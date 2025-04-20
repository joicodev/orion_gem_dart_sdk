import 'package:ai_chat_dart_sdk/src/core/storage/domain/secure_storage_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepositoryImpl extends SecureStorageRepository {
  final String _accessToken = "access_token";
  final String _refreshToken = "refresh_token";

  final _secureStorage = FlutterSecureStorage();

  @override
  Future<String?> readAccessToken() async {
    return await _secureStorage.read(key: _accessToken);
  }

  @override
  Future<String?> readRefreshToken([bool remove = true]) async {
    final token = await _secureStorage.read(key: _refreshToken);
    if (token != null && remove) {
      await _secureStorage.delete(key: _refreshToken);
    }
    return token;
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: _accessToken, value: token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: _refreshToken, value: token);
  }

  /* @override
  Future<void> saveToken(RegisterFirebaseResponseModel userInfo) async {
    await saveAccessToken(userInfo.access);
    await saveRefreshToken(userInfo.refresh);
  } */

  @override
  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessToken);
    await _secureStorage.delete(key: _refreshToken);
  }
}
