import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences _prefs;

  static String _lastSearch = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
 }


  static String get lastSearch {
    return _prefs.getString('last_search') ?? _lastSearch;
  }

  static set lastSearch(String value) {
    _lastSearch = value;
    _prefs.setString('last_search', value);
  }


}
