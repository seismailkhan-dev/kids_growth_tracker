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


  static const String keyUserData = 'user_data';
  static const String keyLoggedIn = 'isLoggedIn';
  static const String isLoggedInTime = 'isLoggedInTime';
  static const String isSkipOnboarding = 'isSkipOnboarding';



  static Future<void> saveUserModel(UserModel user) async {
    final jsonString = jsonEncode(user.toJson());
    await _prefs.setString(keyUserData, jsonString);
  }

  static UserModel? getUserModel() {
    final jsonString = _prefs.getString(keyUserData);
    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return UserModel.fromJson(jsonMap);
  }


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
  static Future<void> saveIsLoggedInTime(DateTime date) async {
    await _prefs.setString(isLoggedInTime, DateTime.now().toIso8601String());
  }


  static Future<DateTime?> getIsLoggedInTime() async {
    final dateString = _prefs.getString(isLoggedInTime);
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
