import 'package:covidspyapp/model/SelectedCounty.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedCountyService {

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<SelectedCounty> browse() async {

    final SharedPreferences prefs = await _prefs;
    final String state = prefs.getString('state') ?? null;
    final String county = prefs.getString('county') ?? null;
    final bool isEnableNotification = prefs.getBool('isEnableNotification') ?? false;
    final bool isTermOfUseAccept = prefs.getBool('isTermOfUseAccept') ?? false;
    if (county == null && state == null) {
      return null;
    }
    return SelectedCounty(county: county, state: state, isEnableNotification: isEnableNotification, isTermOfUseAccept: isTermOfUseAccept);
  }

  static Future<SelectedCounty> commit(SelectedCounty selectedCounty) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString("state", selectedCounty.state).then((bool success) {
      return print('commit ${selectedCounty.state}');
    });

    prefs.setString("county", selectedCounty.county).then((bool success) {
      return print('commit ${selectedCounty.county}');
    });

      return selectedCounty;
    }

  static Future<bool> commitIsEnableNotification(bool isEnableNotification) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setBool("isEnableNotification", isEnableNotification).then((bool success) {
      return print('commit isEnableNotification: $isEnableNotification');
    });

    return isEnableNotification;
  }

  static Future<bool> commitIsTermOfUseAccept(bool isTermOfUseAccept) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setBool("isTermOfUseAccept", isTermOfUseAccept).then((bool success) {
      return print('commit isEnableNotification: $isTermOfUseAccept');
    });

    return isTermOfUseAccept;
  }
}
