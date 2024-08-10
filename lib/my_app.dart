import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gif_collection/generated/locales.g.dart';
import 'package:gif_collection/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateRoute: AppRoute.generateRoute,
      locale: const Locale('vi', 'VI'),
      translationsKeys: AppTranslation.translations,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorKey: Get.key,
      theme: _buildThemeData(context),
      initialRoute: AppRoute.splashScreen,
      builder: EasyLoading.init(),
    );
  }

  /// Theme data
  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
      // primaryTextTheme:
      //     GoogleFonts.sourceSansProTextTheme(Theme.of(context).textTheme),
      // textTheme:
      //     GoogleFonts.sourceSansProTextTheme(Theme.of(context).textTheme),
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      primaryColor: Colors.black,
      primarySwatch: MaterialColor(
        // F.appFlavor == Flavor.VOUCHER_FOR_YOU
        //     ? 0xff3b97b7 : /*nếu là voucher for you thì trả về màu nền khác*/
        0xffd67d2f,
        // F.appFlavor == Flavor.VOUCHER_FOR_YOU
        //     ? {
        //         50: Color(0xff3b97b7),
        //         100: Color(0xff3b97b7),
        //         200: Color(0xff3b97b7),
        //         300: Color(0xff3b97b7),
        //         400: Color(0xff3b97b7),
        //         500: Color(0xff3b97b7),
        //         600: Color(0xff3b97b7),
        //         700: Color(0xff3b97b7),
        //         800: Color(0xff3b97b7),
        //         900: Color(0xff3b97b7),
        //       } :
        const {
          50: Color(0xffd67d2f),
          100: Color(0xffd67d2f),
          200: Color(0xffd67d2f),
          300: Color(0xffd67d2f),
          400: Color(0xffd67d2f),
          500: Color(0xffd67d2f),
          600: Color(0xffd67d2f),
          700: Color(0xffd67d2f),
          800: Color(0xffd67d2f),
          900: Color(0xffd67d2f),
        },
      ),
    );
  }
}
