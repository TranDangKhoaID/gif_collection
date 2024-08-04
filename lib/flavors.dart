enum Flavor {
  gif_collection,
  gif_collection_18,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.gif_collection:
        return 'Gif Collection';
      case Flavor.gif_collection_18:
        return 'Gif Collection 18';
      default:
        return 'title';
    }
  }

}
