import 'package:dio/dio.dart';
import '../services/token_service.dart';

class DioClient {
  final Dio dio;
  final TokenService tokenService;

  DioClient(String baseUrl, this.tokenService)
      : dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await tokenService.accessToken;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (e, handler) async {
        // 토큰 만료 처리
        if (e.response?.statusCode == 401) {
          final refreshed = await _refreshToken();
          if (refreshed) {
            final req = e.requestOptions;
            final newToken = await tokenService.accessToken;
            req.headers['Authorization'] = 'Bearer $newToken';
            final clone = await dio.fetch(req);
            return handler.resolve(clone);
          }
        }
        handler.next(e);
      },
    ));
  }

  Future<bool> _refreshToken() async {
    try {
      final refresh = await tokenService.refreshToken;
      if (refresh == null) return false;
      final res = await dio.patch('/auth/refresh', data: {'refreshToken': refresh});
      final newAccess = res.data['accessToken'] as String?;
      if (newAccess == null) return false;
      await tokenService.saveTokens(access: newAccess);
      return true;
    } catch (_) {
      await tokenService.clear();
      return false;
    }
  }
}
