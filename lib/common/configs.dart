import 'package:tikimon_collection/common/constants.dart';
import 'package:tikimon_collection/flavors.dart';

class Configs {
  /// Base URL
  static String kBaseUrl() {
    if (F.appFlavor == Flavor.gif_collection) {
      return 'https://qksxpfktdruyfndjfcwf.supabase.co';
    } else if (F.appFlavor == Flavor.gif_collection_18) {
      return 'https://pdztvdfolatzenkqmvrt.supabase.co';
    }
    return 'https://qksxpfktdruyfndjfcwf.supabase.co';
  }

  // static String kAPIKey() {
  //   if (F.appFlavor == Flavor.gif_collection) {
  //     return Constants.supabaseBaseKeyGif;
  //   } else if (F.appFlavor == Flavor.gif_collection_18) {
  //     return Constants.supabaseBaseKeyGif18;
  //   }
  //   return Constants.supabaseBaseKeyGif18;
  // }
}
