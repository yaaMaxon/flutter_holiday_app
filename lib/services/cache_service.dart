import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  Future<void> saveHolidays(List<dynamic> holidays) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('holidays', json.encode(holidays));
  }

  Future<List<dynamic>?> getHolidays() async {
    final prefs = await SharedPreferences.getInstance();
    final holidaysData = prefs.getString('holidays');
    if (holidaysData != null) {
      return json.decode(holidaysData) as List<dynamic>;
    }
    return null;
  }
}
