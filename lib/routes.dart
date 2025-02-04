import 'package:gif_collection/navigation_menu.dart';
import 'package:gif_collection/screens/create_character/create_character_screen.dart';
import 'package:gif_collection/screens/create_character/sign_in_screen.dart';
import 'package:gif_collection/screens/account/search_screen.dart';
import 'package:gif_collection/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  /// MARK: - Initials;
  static const String splashScreen = '/splash-screen';
  static const String createCharacterScreen = '/create-character-screen';
  static const String navigationMenu = '/navigation-menu';
  static const String signInScreen = '/sign-in-screen';
  static const String searchScreen = '/search-screen';

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
      case signInScreen:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: settings,
        );
      case searchScreen:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
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
          title: const Text('Lỗi'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('page_not_found'),
        ),
      );
    });
  }
}
