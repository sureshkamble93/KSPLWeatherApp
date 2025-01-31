// Weather Events

abstract class WeatherEvent {}

class FetchWeatherByCoordinates extends WeatherEvent {
  final double latitude;
  final double longitude;
  FetchWeatherByCoordinates(this.latitude, this.longitude);
}

class FetchWeatherByCity extends WeatherEvent {
  final String city;
  FetchWeatherByCity(this.city);
}