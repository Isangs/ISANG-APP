import 'package:flutter/material.dart';
import 'package:isang/presentation/auth/view/login_screen.dart';
import 'package:isang/presentation/navigation/view/navigation_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const navigation = '/navigation';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.navigation:
        return MaterialPageRoute(builder: (context) => const NavigationScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Not Found'),),
          ),
        );
    }
  }
}
