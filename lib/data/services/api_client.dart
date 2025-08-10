import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  static const String baseUrl = 'https://api.isang.site/';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static ApiClient? _instance;
  late Dio _dio;

  // 싱글톤 패턴
  static ApiClient get instance {
    _instance ??= ApiClient._internal();
    return _instance!;
  }

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // 인터셉터 설정
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 로그인 관련 요청이 아닌 경우에만 토큰 추가
          if (!_isAuthRequest(options.path)) {
            final accessToken = await _storage.read(key: 'accessToken');
            if (accessToken != null) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          // 401 에러 (토큰 만료) 시 토큰 재발급 시도
          if (error.response?.statusCode == 401 && !_isAuthRequest(error.requestOptions.path)) {
            final refreshSuccess = await _refreshToken();
            if (refreshSuccess) {
              // 토큰 재발급 성공 시 원래 요청 재시도
              final accessToken = await _storage.read(key: 'accessToken');
              error.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
              
              try {
                final response = await _dio.fetch(error.requestOptions);
                handler.resolve(response);
                return;
              } catch (e) {
                handler.next(error);
                return;
              }
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  // 인증 관련 요청인지 확인
  bool _isAuthRequest(String path) {
    return path.contains('/auth/oauth/login') || 
           path.contains('/auth/oauth/kakao') ||
           path.contains('/auth/refresh');
  }

  // 토큰 재발급
  Future<bool> _refreshToken() async {
    try {
      final accessToken = await _storage.read(key: 'accessToken');
      final refreshToken = await _storage.read(key: 'refreshToken');
      if (accessToken == null || refreshToken == null) return false;

      final response = await _dio.post(
        '/auth/refresh',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Refresh-Token': 'Bearer $refreshToken',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['isSuccess'] == true) {
        final result = response.data['result'];
        await _storage.write(key: 'accessToken', value: result['accessToken']);
        return true;
      }
      return false;
    } catch (error) {
      print('토큰 재발급 에러: $error');
      return false;
    }
  }

  // GET 요청
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  // POST 요청
  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.post(path, data: data, queryParameters: queryParameters);
  }

  // PATCH 요청
  Future<Response> patch(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.patch(path, data: data, queryParameters: queryParameters);
  }

  // DELETE 요청
  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.delete(path, data: data, queryParameters: queryParameters);
  }

  // 파일 업로드
  Future<Response> uploadFile(String path, String filePath) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });
    return await _dio.post(path, data: formData);
  }

  // Dio 인스턴스 직접 접근 (필요한 경우)
  Dio get dio => _dio;
}
