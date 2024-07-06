import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = 'ca4837039fc0a2bf2767b8c1738598ae';
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String city) async {
    final response =
        await http.get(Uri.parse('$apiUrl?q=$city&units=metric&appid=$apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
