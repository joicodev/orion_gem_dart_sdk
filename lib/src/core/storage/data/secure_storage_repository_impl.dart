/* import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:orion_gem_dart_sdk/orion_gem_dart_sdk.dart';

class SecureStorageRepositoryImpl extends SecureStorageRepository {
  final String _accessToken = "access_token";
  final String _refreshToken = "refresh_token";

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

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
 */
