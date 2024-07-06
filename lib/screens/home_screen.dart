import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import 'weather_screen.dart';
import '../models/weather_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            if (_weather != null)
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
                    return WeatherScreen(weather: weather);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
