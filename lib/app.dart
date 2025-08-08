import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart';
import 'core/theme/theme.dart';

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
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
