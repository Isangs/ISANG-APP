import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' hide Options;

class AuthService {
  static const String baseUrl = 'https://api.isang.site'; // 팀 API 서버 URL
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  final Dio _dio = Dio();

  AuthService() {
    // Dio 인터셉터 설정 - JWT 토큰 자동 첨부
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 로그인/회원가입 요청이 아닌 경우에만 토큰 첨부
        if (!options.path.contains('/auth/oauth/login') &&
            !options.path.contains('/auth/refresh') &&
            !options.path.contains('/auth/oauth/kakao')) {
          final accessToken = await _storage.read(key: 'accessToken');
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        // 401 에러 시 토큰 재발급 시도
        if (error.response?.statusCode == 401) {
          final refreshed = await _refreshToken();
          if (refreshed) {
            // 토큰 재발급 성공 시 원래 요청 재시도
            final accessToken = await _storage.read(key: 'accessToken');
            error.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
            final response = await _dio.fetch(error.requestOptions);
            handler.resolve(response);
            return;
          }
        }
        handler.next(error);
      },
    ));
  }

  // 카카오 로그인 - 커스텀 스킴(redirectUri: 'isang://oauth') 방식으로 인가 코드 받아 서버에 전달
  Future<Map<String, dynamic>?> loginWithKakao() async {
    try {
      print('카카오 로그인 시작...');
      String? authCode;
      if (await isKakaoTalkInstalled()) {
        authCode = await AuthCodeClient.instance.authorizeWithTalk(
          redirectUri: 'kakao7c96d2d6f1f07f1b76ffabb890845f4b://oauth'
        );
      } else {
        authCode = await AuthCodeClient.instance.authorize(
          redirectUri: 'kakao7c96d2d6f1f07f1b76ffabb890845f4b://oauth',
        );
      }
      if (authCode == null) {
        return {'success': false, 'message': 'Authorization Code를 받지 못했습니다.'};
      }
      print('Authorization Code 획득 성공: ${authCode.substring(0, 10)}...');
      // 서버에 code를 path param으로 전달
      final response = await _dio.post(
        '$baseUrl/auth/oauth/login/$authCode/app',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print('서버 응답: ${response.statusCode}');
      print('응답 데이터: ${response.data}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          // 케이스 1: 평평한 구조 { accessToken, refreshToken, role? }
          if (responseData.containsKey('accessToken')) {
            await _saveTokens(responseData);
            return {'success': true, 'message': '로그인 성공'};
          }
          // 케이스 2: 래핑 구조 { isSuccess: true, result: { accessToken, refreshToken, role? } }
          if (responseData['isSuccess'] == true && responseData['result'] is Map<String, dynamic>) {
            final result = Map<String, dynamic>.from(responseData['result']);
            if (result.containsKey('accessToken')) {
              await _saveTokens(result);
              return {'success': true, 'message': '로그인 성공'};
            }
          }
        }
      }
      return {
        'success': false,
        'message': '서버 인증에 실패했습니다. (${response.statusCode})'
      };
    } catch (error) {
      print('카카오 로그인 에러: $error');
      if (error is PlatformException) {
        switch (error.code) {
          case 'CANCELED':
            return {'success': false, 'message': '로그인이 취소되었습니다.'};
          case 'NOT_SUPPORTED':
            return {'success': false, 'message': '지원되지 않는 기능입니다.'};
          case 'INVALID_REQUEST':
            return {'success': false, 'message': '잘못된 요청입니다.'};
          default:
            return {'success': false, 'message': '카카오 로그인 중 오류가 발생했습니다: ${error.message}'};
        }
      } else if (error is DioException) {
        print('DioException 상세 정보:');
        print('- Status Code: ${error.response?.statusCode}');
        print('- Response Data: ${error.response?.data}');
        print('- Request URL: ${error.requestOptions.uri}');
        print('- Request Method: ${error.requestOptions.method}');
        if (error.response?.statusCode == 530) {
          return {
            'success': false,
            'message': '서버에서 code를 처리할 수 없습니다. 팀에게 서버 상태를 확인 요청하세요.',
            'error_details': {
              'status_code': 530,
              'response_data': error.response?.data,
            }
          };
        } else if (error.response?.statusCode == 401) {
          return {'success': false, 'message': '인증에 실패했습니다.'};
        } else if (error.response?.statusCode == 403) {
          return {'success': false, 'message': '권한이 없습니다.'};
        } else if (error.response?.statusCode == 404) {
          return {'success': false, 'message': '서버를 찾을 수 없습니다.'};
        }
        return {'success': false, 'message': '서버 연결에 실패했습니다.'};
      }
      return {'success': false, 'message': '로그인 중 오류가 발생했습니다.'};
    }
  }

  // 토큰 저장 헬퍼 메서드
  Future<void> _saveTokens(Map<String, dynamic> tokenData) async {
    if (tokenData['accessToken'] != null) {
      await _storage.write(key: 'accessToken', value: tokenData['accessToken']);
    }
    if (tokenData['refreshToken'] != null) {
      await _storage.write(key: 'refreshToken', value: tokenData['refreshToken']);
    }
    if (tokenData['role'] != null) {
      await _storage.write(key: 'userRole', value: tokenData['role']);
    }
    print('토큰 저장 완료');
  }

  // JWT 토큰 재발급
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _storage.read(key: 'refreshToken');
      if (refreshToken == null) return false;

      final response = await _dio.post(
        '$baseUrl/auth/refresh',
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('isSuccess') && responseData['isSuccess'] == true) {
            final result = responseData['result'];
            await _saveTokens(result);
            return true;
          } else if (responseData.containsKey('accessToken')) {
            await _saveTokens(responseData);
            return true;
          }
        }
      }
      return false;
    } catch (error) {
      print('토큰 재발급 실패: $error');
      return false;
    }
  }

  // 로그아웃
  Future<Map<String, dynamic>> logout() async {
    try {
      // 1. 서버 로그아웃
      try {
        await _dio.post('$baseUrl/auth/logout');
      } catch (e) {
        print('서버 로그아웃 실패 (무시): $e');
      }

      // 2. 카카오 로그아웃
      try {
        await UserApi.instance.logout();
        print('카카오 로그아웃 성공');
      } catch (error) {
        print('카카오 로그아웃 실패 (무시): $error');
      }

      // 3. 로컬 토큰 삭제
      await _storage.delete(key: 'accessToken');
      await _storage.delete(key: 'refreshToken');
      await _storage.delete(key: 'userRole');
      print('로컬 토큰 삭제 완료');

      return {'success': true, 'message': '로그아웃되었습니다.'};
    } catch (error) {
      print('로그아웃 에러: $error');
      return {'success': false, 'message': '로그아웃 중 오류가 발생했습니다.'};
    }
  }

  // 로그인 상태 확인
  Future<bool> isLoggedIn() async {
    final accessToken = await _storage.read(key: 'accessToken');
    return accessToken != null;
  }

  // 저장된 사용자 역할 가져오기
  Future<String?> getUserRole() async {
    return await _storage.read(key: 'userRole');
  }

  // 액세스 토큰 가져오기
  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }
}
