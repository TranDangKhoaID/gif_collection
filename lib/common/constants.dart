import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String supabaseBaseUrl = dotenv.env['SUPABASE_BASE_URL'] ?? '';
  static String supabaseBaseKey = dotenv.env['SUPABASE_BASE_KEY'] ?? '';
}
