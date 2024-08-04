import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tikimon_collection/flavors.dart';

class Constants {
  static String supabaseBaseUrlGif = dotenv.env['SUPABASE_BASE_URL_GIF'] ?? '';
  static String supabaseBaseKeyGif = dotenv.env['SUPABASE_BASE_KEY_GIF'] ?? '';
  //
  static String supabaseBaseUrlGif18 =
      dotenv.env['SUPABASE_BASE_URL_GIF_18'] ?? '';
  static String supabaseBaseKeyGif18 =
      dotenv.env['SUPABASE_BASE_KEY_GIF_18'] ?? '';

  static String kAPIKey() {
    if (F.appFlavor == Flavor.gif_collection) {
      return supabaseBaseKeyGif;
    } else if (F.appFlavor == Flavor.gif_collection_18) {
      return supabaseBaseKeyGif18;
    }
    return supabaseBaseKeyGif;
  }

  static String kBaseUrl() {
    if (F.appFlavor == Flavor.gif_collection) {
      return supabaseBaseUrlGif;
    } else if (F.appFlavor == Flavor.gif_collection_18) {
      return supabaseBaseUrlGif18;
    }
    return supabaseBaseUrlGif;
  }
}
