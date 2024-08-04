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
        return 'Gif Pixel Collection';
      case Flavor.gif_collection_18:
        return 'Gif Pixel Collection 18';
      default:
        return 'title';
    }
  }
}
