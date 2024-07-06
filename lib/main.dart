import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  Future<Weather>? _weather;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter City',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _weather = _weatherService.fetchWeather(_controller.text);
                    });
                  },
                ),
              ),
            ),
            FutureBuilder<Weather>(
              future: _weather,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('No weather data');
                } else {
                  Weather weather = snapshot.data!;
                  return Column(
                    children: [
                      Text(weather.city, style: TextStyle(fontSize: 24)),
                      BoxedIcon(_getWeatherIcon(weather.condition), size: 100),
                      Text('${weather.temperature}°C',
                          style: TextStyle(fontSize: 48)),
                      Text(weather.description, style: TextStyle(fontSize: 24)),
                    ],
                  );
                }
              },
            ),
          ],
        ),
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
