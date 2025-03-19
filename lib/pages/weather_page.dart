import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_app/models/weather_model.dart';
import 'package:wallpaper_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(
    apiKey: '3fb95830fef88ccabc8281fd533cd96c',
  );
  WeatherModel? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'lib/assets/sunny.json';
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'lib/assets/clouds.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'lib/assets/rain.json';
      case 'thunderstorm':
        return 'lib/assets/thunder.json';
      case 'clear':
        return 'lib/assets/sun.json';
      default:
        return 'lib/assets/sun.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final iconColor = theme.colorScheme.primary;
    final screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers everything
          crossAxisAlignment:
              CrossAxisAlignment.center, // Ensures horizontal centering
          children: [
            Icon(Icons.location_on, color: iconColor, size: screenWidth * 0.08),
            SizedBox(height: screenHeight * 0.02),

            // City Name
            Text(
              _weather?.cityName.toUpperCase() ?? "Loading City...",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.bold,
                color: textColor,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Weather Animation
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition ?? " "),
              width: screenWidth * 0.6,
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.05),

            // Temperature
            Text(
              '${_weather?.temperature.round()}°',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.12,
                fontWeight: FontWeight.bold,
                color: textColor,
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.black38,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
