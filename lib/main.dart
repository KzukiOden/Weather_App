import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallpaper_app/pages/weather_page.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.light(
          surface: Colors.white,
          onSurface: Colors.grey.shade800,
          primary: Colors.grey,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey,
        colorScheme: ColorScheme.dark(
          surface: Colors.black,
          onSurface: Colors.white,
          primary: Colors.grey,
        ),
      ),
      themeMode:
          ThemeMode.system, // Automatically switch based on system settings
      home: const WeatherPage(),
    );
  }
}
