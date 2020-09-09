import 'package:flutter/material.dart';
import 'package:weather_app_verion2/weather_bloc/bloc.dart';
import './screen/today_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './weather_bloc/weather_repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return BlocProvider(
        create: (context) => WeatherBloc(WeatherDays()),
        child: MaterialApp(
          title: 'Weather App',
          home: WeatherScreen(),
    ),
      );
  }
}
