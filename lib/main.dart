import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gif_collection/common/configs.dart';
import 'package:gif_collection/locator.dart';
import 'package:gif_collection/my_app.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Giới hạn chỉ cho màn hình dọc
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //fire base
  await Firebase.initializeApp();
  //supabase
  await dotenv.load();

  await Supabase.initialize(
    url: Configs.kBaseUrl(),
    anonKey: Configs.kAPIKey(),
  );

  configureDependencies();

  runApp(const MyApp());
}
