import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_kspl/models/weather.dart';
// Weather Service - Handles API requests
class WeatherService {
  final String apiKey = 'YOUR_API_NINJA_KEY';
  // Fetch weather using latitude and longitude

  Future<Weather> fetchWeatherByCoordinates(double latitude, double longitude) async {
    String url = 'https://api.api-ninjas.com/v1/weather?lat=$latitude&lon=$longitude';
    var response = await http.get(Uri.parse(url), headers: {'X-Api-Key': apiKey});
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
  // Fetch weather using city name

  Future<Weather> fetchWeatherByCity(String city) async {
    String url = 'https://api.api-ninjas.com/v1/weather?city=$city';
    var response = await http.get(Uri.parse(url), headers: {'X-Api-Key': apiKey});
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}

