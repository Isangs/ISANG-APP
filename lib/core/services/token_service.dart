import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  final _s = const FlutterSecureStorage();

  Future<void> saveTokens({required String access, String? refresh}) async {
    await _s.write(key: 'accessToken', value: access);
    if (refresh != null) await _s.write(key: 'refreshToken', value: refresh);
  }

  Future<String?> get accessToken async => await _s.read(key: 'accessToken');
  Future<String?> get refreshToken async => await _s.read(key: 'refreshToken');

  Future<void> clear() async {
    await _s.delete(key: 'accessToken');
    await _s.delete(key: 'refreshToken');
  }
}
