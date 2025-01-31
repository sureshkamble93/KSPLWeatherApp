import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_kspl/database/hive_database.dart';
import 'package:weather_app_kspl/repository/weather_repository.dart';
import 'package:weather_app_kspl/screens/weather_screen.dart';
import 'package:weather_app_kspl/services/weather_service.dart';

import 'blocs/weather_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDatabase.init();
  runApp(BlocProvider(
    create: (context) => WeatherBloc(WeatherRepository(WeatherService()), HiveDatabase()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}


