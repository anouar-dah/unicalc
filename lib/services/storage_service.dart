import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _historyKey = 'calculationHistory';

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyString = prefs.getString(_historyKey);
    if (historyString == null) {
      return [];
    }
    final List<dynamic> historyList = jsonDecode(historyString);
    return historyList.map((e) => e as Map<String, dynamic>).toList();
  }

  static Future<void> saveCalculation(List<Map<String, dynamic>> courses, double average) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> history = await getHistory();

    final newEntry = {
      'date': DateTime.now().toIso8601String(),
      'average': average,
      'courses': courses,
    };

    history.insert(0, newEntry); // Add to the beginning
    await prefs.setString(_historyKey, jsonEncode(history));
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}