import 'package:flutter/material.dart';
import './screen/today_screen.dart';
import 'package:provider/provider.dart';
import './provider/weather_provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: WeatherDays(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        home: WeatherScreen(),
      ),
    );
  }
}
