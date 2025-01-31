import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_kspl/blocs/weather_bloc.dart';

import 'package:weather_app_kspl/blocs/weather_event.dart';
import 'package:weather_app_kspl/blocs/weather_state.dart';
import 'package:weather_app_kspl/services/location_service.dart';
import 'package:weather_app_kspl/widgets/weather_card.dart';
// UI Screen with Search Functionality

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isCelsius = true;
  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

  }
  // Fetch current location and request weather data

  Future<void> _getCurrentLocation() async {
    Position? position = await LocationService.getCurrentLocation();
    if (position != null) {
      context.read<WeatherBloc>().add(FetchWeatherByCoordinates(position.latitude, position.longitude));
    }
  }
  // Convert temperature based on unit selection

  String convertTemperature(String temperature) {
    double temp = double.tryParse(temperature) ?? 0.0;
    if (isCelsius) {
      return "${temp.toStringAsFixed(1)} °C";
    } else {
      double fahrenheit = (temp * 9/5) + 32;
      return "${fahrenheit.toStringAsFixed(1)} °F";
    }
  }
  // Search weather by city name

  void _searchCityWeather() {
    if (_searchController.text.isNotEmpty) {
      context.read<WeatherBloc>().add(FetchWeatherByCity(_searchController.text));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          Row(
            children: [
              Text("°C"),
              Switch(
                value: isCelsius,
                onChanged: (value) {
                  setState(() {
                    isCelsius = value;
                  });
                },
              ),
              Text("°F"),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search City',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchCityWeather,
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WeatherLoaded) {
                  return Center(
                    child: WeatherCard(
                      condition: state.weather.condition,
                      temperature: convertTemperature(state.weather.temperature),
                    ),
                  );
                } else if (state is WeatherError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text("Fetching Weather..."));
              },
            ),
          ),
        ],
      ),
    );
  }

}
