import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String _userKey = 'user';
  static const String _holidaysKey = 'holidays';

  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, json.encode(user));
  }

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData != null) {
      return json.decode(userData) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_userKey);
  }

  Future<void> saveHolidays(List<Map<String, dynamic>> holidays) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_holidaysKey, json.encode(holidays));
  }

  Future<List<Map<String, dynamic>>?> getHolidays() async {
    final prefs = await SharedPreferences.getInstance();
    final holidaysData = prefs.getString(_holidaysKey);
    if (holidaysData != null) {
      return (json.decode(holidaysData) as List<dynamic>)
          .map((holiday) => holiday as Map<String, dynamic>)
          .toList();
    }
    return null;
  }

  Future<void> clearHolidays() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_holidaysKey);
  }
}
