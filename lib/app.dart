import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart';
import 'core/theme/theme.dart';

// Global navigator key for navigation from non-widget contexts (e.g., deep link handler)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class IdealApp extends ConsumerWidget {
  const IdealApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: '이상',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, // 나중에 ViewModel로 조절 가능
      initialRoute: AppRoutes.login, // 로그인 없이 바로 홈페이지(피드)로 이동
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
