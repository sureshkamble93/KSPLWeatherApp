import 'package:weather_app_kspl/models/weather.dart';
import 'package:weather_app_kspl/services/weather_service.dart';
// Weather Repository

class WeatherRepository {
  final WeatherService weatherService;

  WeatherRepository(this.weatherService);

  Future<Weather> getWeatherByCoordinates(double latitude, double longitude) async {
    return await weatherService.fetchWeatherByCoordinates(latitude, longitude);
  }

  Future<Weather> getWeatherByCity(String city) async {
    return await weatherService.fetchWeatherByCity(city);
  }
}
