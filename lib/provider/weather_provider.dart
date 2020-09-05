import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_verion2/database/database_helper.dart';
import 'dart:convert';
import '../model/weather_model.dart';


class WeatherDays extends ChangeNotifier {

  DatabaseHelper helper = DatabaseHelper();
  List<Weather> _weatherDay = [];

  List<Weather> get items {
    return [..._weatherDay];
  }

  Future<void> fetchWeatherData() async {
    try {
      const url =
          "https://samples.openweathermap.org/data/2.5/forecast/daily?q=M%C3%BCnchen,DE&appid=b6907d289e10d714a6e88b30761fae22";
      final response = await http.get(url);
      final extractedData = (json.decode(response.body))['list'] as List<dynamic>;
      final List<Weather> _loadedWeatherDate = [];

      extractedData.forEach((element) {
        _loadedWeatherDate.add(Weather.fromMap(element));
      });
      notifyListeners();
      _weatherDay = _loadedWeatherDate;
    //  debugPrint(_weatherDay.length.toString());
      _weatherDay.forEach((element) {
        helper.saveItem(element);
      });
    } catch (error) {
      throw (error);
    }
  }
}


