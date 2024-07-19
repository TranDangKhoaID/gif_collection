enum Flavor {
  FOODIE_HOUSE,
  RELISH_SPA,
  MY_FARM,
  DI4L_ECOMMERCE,
  VOUCHER_FOR_YOU,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.FOODIE_HOUSE:
        return 'Foodie House';
      case Flavor.RELISH_SPA:
        return 'Relish Spa';
      case Flavor.MY_FARM:
        return 'My Farm';
      case Flavor.DI4L_ECOMMERCE:
        return 'Di4L Ecommerce';
      case Flavor.VOUCHER_FOR_YOU:
        return 'Voucher For You';
      default:
        return 'title';
    }
  }

}
