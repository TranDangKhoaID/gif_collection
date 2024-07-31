import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:tikimon_collection/firebase_options.dart';
import 'package:tikimon_collection/locator.dart';
import 'package:tikimon_collection/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Giới hạn chỉ cho màn hình dọc
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const MyApp());
}
