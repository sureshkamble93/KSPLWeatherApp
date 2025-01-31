import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app_kspl/models/weather.dart';

class HiveDatabase {
  static Box? weatherBox;

  static Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    weatherBox = await Hive.openBox('weatherBox');
  }

  static void saveWeatherData(Weather weather) {
    weatherBox?.put('weather', weather.toJson());
  }

  static Weather? getWeatherData() {
    var data = weatherBox?.get('weather');
    return data != null ? Weather.fromJson(data) : null;
  }
}
