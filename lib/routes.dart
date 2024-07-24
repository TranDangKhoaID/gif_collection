import 'package:tikimon_collection/navigation_menu.dart';
import 'package:tikimon_collection/screens/create_character/create_character_screen.dart';
import 'package:tikimon_collection/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  /// MARK: - Initials;
  static const String splashScreen = '/splash-screen';
  static const String createCharacterScreen = '/create-character-screen';
  static const String navigationMenu = '/navigation-menu';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case createCharacterScreen:
        return MaterialPageRoute(
          builder: (_) => const CreateCharacterScreen(),
          settings: settings,
        );
      case navigationMenu:
        return MaterialPageRoute(
          builder: (_) => const NavigationMenu(),
          settings: settings,
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Lỗi'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('page_not_found'),
        ),
      );
    });
  }
}
