import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://www.gov.uk/bank-holidays.json';

  Future<List<Map<String, dynamic>>> fetchHolidays() async {
    final http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> holidays = data['england-and-wales']['events'];
      return holidays.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to fetch holidays');
    }
  }
}
