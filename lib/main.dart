import 'package:card_tikimon_collection/locator.dart';
import 'package:card_tikimon_collection/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}
