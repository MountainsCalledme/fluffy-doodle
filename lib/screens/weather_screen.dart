import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherScreen extends StatelessWidget {
  final Weather weather;

  WeatherScreen({required this.weather});

  @override
  Widget build(BuildContext context) {
    String _getBackgroundImage() {
      int hour = weather.localTime.hour;
      if (hour >= 5 && hour < 12) {
        return 'assets/morning.jpg';
      } else if (hour >= 12 && hour < 17) {
        return 'assets/afternoon.jpg';
      } else if (hour >= 17 && hour < 20) {
        return 'assets/evening.jpg';
      } else {
        return 'assets/night.jpg';
      }
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_getBackgroundImage()),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Text(weather.city,
              style: TextStyle(fontSize: 24, color: Colors.white)),
          BoxedIcon(_getWeatherIcon(weather.condition),
              size: 100, color: Colors.white),
          Text('${weather.temperature}°C',
              style: TextStyle(fontSize: 48, color: Colors.white)),
          Text(weather.description,
              style: TextStyle(fontSize: 24, color: Colors.white)),
          Text('Humidity: ${weather.humidity}%',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          Text('Wind Speed: ${weather.windSpeed} m/s',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          ElevatedButton(
            onPressed: () {
              // Refresh functionality to fetch updated weather data
            },
            child: Text('Refresh'),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition) {
      case 'Clear':
        return WeatherIcons.day_sunny;
      case 'Clouds':
        return WeatherIcons.cloudy;
      case 'Rain':
        return WeatherIcons.rain;
      case 'Snow':
        return WeatherIcons.snow;
      case 'Thunderstorm':
        return WeatherIcons.thunderstorm;
      case 'Drizzle':
        return WeatherIcons.sprinkle;
      case 'Mist':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.cloud;
    }
  }
}
