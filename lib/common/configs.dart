import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tikimon_collection/flavors.dart';

class Configs {
  static String baseUrlGif = dotenv.env['BASE_URL_GIF']!;
  static String baseKeyGif = dotenv.env['BASE_KEY_GIF']!;
  //
  static String baseUrlGif18 = dotenv.env['BASE_URL_GIF_18']!;
  static String baseKeyGif18 = dotenv.env['BASE_KEY_GIF_18']!;

  static String kAPIKey() {
    if (F.appFlavor == Flavor.gif_collection) {
      return baseKeyGif;
    } else if (F.appFlavor == Flavor.gif_collection_18) {
      return baseKeyGif18;
    }
    return baseKeyGif;
  }

  static String kBaseUrl() {
    if (F.appFlavor == Flavor.gif_collection) {
      return baseUrlGif;
    } else if (F.appFlavor == Flavor.gif_collection_18) {
      return baseUrlGif18;
    }
    return baseUrlGif;
  }
}
