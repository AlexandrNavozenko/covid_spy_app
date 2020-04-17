import 'dart:io' show Platform;

class AdmobUtility {
  static String _AndroidAppId = 'ca-app-pub-3940256099942544~3347511713'; // ignore: non_constant_identifier_names
  static String _AndroidUnitId = 'ca-app-pub-3940256099942544/8135179316'; // ignore: non_constant_identifier_names
  static String _IosAppId = ''; // ignore: non_constant_identifier_names
  static String _IosUnitId = ''; // ignore: non_constant_identifier_names

  static String getAppId() {
    if (Platform.isIOS) {
      return _IosAppId;
    } else if (Platform.isAndroid) {
      return _AndroidAppId;
    }
    return null;
  }

  static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return _IosUnitId;
    } else if (Platform.isAndroid) {
      return _AndroidUnitId;
    }
    return null;
  }
}