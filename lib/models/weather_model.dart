class Weather {
  final String city;
  final double temperature;
  final String description;
  final String condition;
  final int humidity;
  final double windSpeed;
  final DateTime localTime;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.localTime,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      condition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      localTime:
          DateTime.now().toUtc().add(Duration(seconds: json['timezone'])),
    );
  }
}
