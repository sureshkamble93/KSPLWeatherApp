class Weather {
  final String condition;
  final String temperature;

  Weather({required this.condition, required this.temperature});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      condition: json['condition'] ?? 'Unknown',
      temperature: json['temperature'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'condition': condition,
      'temperature': temperature,
    };
  }
}