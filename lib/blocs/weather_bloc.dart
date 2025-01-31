import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app_kspl/blocs/weather_event.dart';
import 'package:weather_app_kspl/blocs/weather_state.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_kspl/database/hive_database.dart';
import 'package:weather_app_kspl/models/weather.dart';
import 'package:weather_app_kspl/repository/weather_repository.dart';
import 'package:weather_app_kspl/services/weather_service.dart';

// Weather BLoC

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  final HiveDatabase hiveDatabase;

  WeatherBloc(this.weatherRepository, this.hiveDatabase) : super(WeatherInitial()) {
    on<FetchWeatherByCoordinates>((event, emit) async {
      emit(WeatherLoading());
      try {
        Weather weather = await weatherRepository.getWeatherByCoordinates(event.latitude, event.longitude);
        HiveDatabase.saveWeatherData(weather);
        emit(WeatherLoaded(weather));
      } catch (e) {
        Weather? cachedWeather = HiveDatabase.getWeatherData();
        if (cachedWeather != null) {
          emit(WeatherLoaded(cachedWeather));
        } else {
          emit(WeatherError('Failed to fetch weather data'));
        }
      }
    });

    on<FetchWeatherByCity>((event, emit) async {
      emit(WeatherLoading());
      try {
        Weather weather = await weatherRepository.getWeatherByCity(event.city);
        HiveDatabase.saveWeatherData(weather);
        emit(WeatherLoaded(weather));
      } catch (e) {
        Weather? cachedWeather = HiveDatabase.getWeatherData();
        if (cachedWeather != null) {
          emit(WeatherLoaded(cachedWeather));
        } else {
          emit(WeatherError('Failed to fetch weather data'));
        }
      }
    });
  }
}