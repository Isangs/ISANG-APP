import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_links/app_links.dart';
import 'package:isang/app_router.dart';
import 'app.dart';

final _secureStorage = const FlutterSecureStorage();
StreamSubscription? _linkSub;
late final AppLinks _appLinks;

Future<void> _handleIncomingLink(Uri uri) async {
  if (uri.scheme != 'isang' || uri.host != 'oauth') return;

  final error = uri.queryParameters['error'];
  if (error != null) {
    // Optionally: show an error UI/log
    return;
  }

  final access = uri.queryParameters['token'];
  final refresh = uri.queryParameters['refresh'];
  final exp = uri.queryParameters['exp'];

  if (access != null) {
    await _secureStorage.write(key: 'accessToken', value: access);
  }
  if (refresh != null) {
    await _secureStorage.write(key: 'refreshToken', value: refresh);
  }
  if (exp != null) {
    await _secureStorage.write(key: 'tokenExp', value: exp);
  }

  // Navigate to home after storing tokens
  navigatorKey.currentState?.pushNamedAndRemoveUntil(
    AppRoutes.navigation,
    (route) => false,
  );
}

Future<void> _initDeepLinks() async {
  _appLinks = AppLinks();
  try {
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      await _handleIncomingLink(initialUri);
    }
  } catch (_) {}

  await _linkSub?.cancel();
  _linkSub = _appLinks.uriLinkStream.listen((Uri uri) {
    _handleIncomingLink(uri);
  }, onError: (_) {
    // ignore errors
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: '7c96d2d6f1f07f1b76ffabb890845f4b', // 팀에서 제공한 카카오 클라이언트 ID
  );
  await _initDeepLinks();
  runApp(const ProviderScope(child: IdealApp()));
}
