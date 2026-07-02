import 'package:dio/dio.dart';

import 'token_storage.dart';

/// Dio interceptor that automatically attaches the stored JWT as a
/// Bearer token to every outgoing request.
///
/// If no token is stored the request is sent as-is (allows unauthenticated
/// endpoints like /api/auth/login to work normally).
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await _tokenStorage.readToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Optional: handle 401 globally (e.g. auto-logout on token expiry)
    // if (err.response?.statusCode == 401) { ... }
    return handler.next(err);
  }
}
