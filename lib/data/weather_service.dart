import 'dart:convert';

import 'package:http/http.dart';

class WeatherService {
  final api = Client();
  Future<Map<String, dynamic>> getWeather(
      String longitude, String latitude) async {
    final baseUrl =
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true";
    try {
      final response = await api.get(Uri.parse(baseUrl));
      return jsonDecode(response.body);
    } catch (e) {
      return Map();
    }
  }
}
