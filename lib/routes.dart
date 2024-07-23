import 'package:card_tikimon_collection/screens/account/account_screen.dart';
import 'package:card_tikimon_collection/screens/create_character/create_character_screen.dart';
import 'package:card_tikimon_collection/screens/home/home_screen.dart';
import 'package:card_tikimon_collection/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  /// MARK: - Initials;
  static const String splashScreen = '/splash-screen';
  static const String createCharacterScreen = '/create-character-screen';
  static const String homeScreen = '/home-screen';
  static const String accountScreen = '/account-screen';

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
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case accountScreen:
        return MaterialPageRoute(
          builder: (_) => const AccountScreen(),
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
