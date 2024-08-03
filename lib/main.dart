import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tikimon_collection/common/constants.dart';
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
  //fire base
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //supabase
  await dotenv.load();

  await Supabase.initialize(
    url: Constants.supabaseBaseUrl,
    anonKey: Constants.supabaseBaseKey,
  );
  configureDependencies();
  runApp(const MyApp());
}
