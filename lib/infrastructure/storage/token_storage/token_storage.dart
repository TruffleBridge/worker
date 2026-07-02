import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _tokenKey = 'auth_token';

  final FlutterSecureStorage _storage;

  const TokenStorage(this._storage);

  /// Persist the [token] to secure storage.
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Returns the stored token, or `null` if none exists.
  Future<String?> readToken() async {
    return _storage.read(key: _tokenKey);
  }

  /// Deletes the stored token (use on sign-out).
  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
