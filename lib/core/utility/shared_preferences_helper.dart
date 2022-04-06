// ignore_for_file: constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

import 'helper.dart';

class SharedPreferencesHelper {
  late SharedPreferences _prefs;

  Future<SharedPreferencesHelper> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  SharedPreferences get prefs => _prefs;

  // keys
  static const String IS_LOGGED_IN = 'isLoggedIn';
  static const String USER_EMAIL = 'userEmail';
  static const String USER_NAME = 'userName';
  static const String USER_ID = 'userId';
  static const String USER_TOKEN = 'userToken';

  // get logged in session
  bool isLoggedIn() {
    return prefs.getBool(IS_LOGGED_IN) ?? false;
  }

  // write logged in session
  Future<bool> logIn() async {
    return prefs.setBool(IS_LOGGED_IN, true);
  }

  Future<bool> logOut() async {
    try {
      await prefs.remove(IS_LOGGED_IN);
      await prefs.remove(USER_EMAIL);
      await prefs.remove(USER_NAME);
      await prefs.remove(USER_ID);
      await prefs.remove(USER_TOKEN);
      return true;
    } catch (e) {
      logMe(e);
      return false;
    }
  }

  // set google current user

  Future<Map<String, dynamic>> getUserSession() async {
    final _user = {
      USER_EMAIL: prefs.getString(USER_EMAIL),
      USER_ID: prefs.getString(USER_ID),
      USER_NAME: prefs.getString(USER_NAME),
      USER_TOKEN: prefs.getString(USER_TOKEN),
    };
    return _user;
  }

  String get userToken => prefs.getString(USER_TOKEN) ?? '';
  String get userName => prefs.getString(USER_NAME) ?? '';
}
