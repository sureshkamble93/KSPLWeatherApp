import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String condition;
  final String temperature;

  WeatherCard({required this.condition, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(condition, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(temperature, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}