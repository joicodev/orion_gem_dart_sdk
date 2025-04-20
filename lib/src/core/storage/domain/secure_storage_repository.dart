abstract class SecureStorageRepository {
  Future<String?> readAccessToken();

  Future<String?> readRefreshToken([bool remove = true]);

  Future<void> saveAccessToken(String token);

  Future<void> saveRefreshToken(String token);

  // Future<void> saveToken(RegisterFirebaseResponseModel userInfo);

  Future<void> clearTokens();
}
