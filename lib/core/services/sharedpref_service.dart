import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

class SharedPrefService {
  static final SharedPrefService _instance = SharedPrefService._internal();
  factory SharedPrefService() => _instance;
  SharedPrefService._internal();

  static late SharedPreferences _prefs;

  /// CALL THIS FIRST IN main()
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  static const String keyLoggedIn = 'isLoggedIn';
  static const String loggedInTime = 'loggedInTime';
  static const String isSkipOnboarding = 'isSkipOnboarding';



  // ================= LOGIN FLAG =================
  static Future<void> saveIsLoggedIn(bool value) async {
    await _prefs.setBool(keyLoggedIn, value);
  }

  static bool getIsLoggedIn() => _prefs.getBool(keyLoggedIn) ?? false;

  static Future<void> saveIsSkipOnboarding() async {
    await _prefs.setBool(isSkipOnboarding, true);
  }

  static bool getIsSkipOnboarding() => _prefs.getBool(isSkipOnboarding) ?? false;


  // ================= LOGIN Time =================
  static Future<void> saveLoggedInTime() async {
    await _prefs.setString(loggedInTime, DateTime.now().toIso8601String());
  }


  static Future<DateTime?> getLoggedInTime() async {
    final dateString = _prefs.getString(loggedInTime);
    if (dateString == null) return null;
    return DateTime.parse(dateString);
  }


// ================= CLEAR =================
  static Future<void> clear() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    await _prefs.clear();
  }



}
