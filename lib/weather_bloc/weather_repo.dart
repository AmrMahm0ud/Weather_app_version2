import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_verion2/database/database_helper.dart';
import 'package:weather_app_verion2/weather_bloc/weather_state.dart';
import 'dart:convert';
import '../model/weather_model.dart';
import 'package:connectivity/connectivity.dart';




abstract class WeatherRepo{
  Future<WeatherState> fetchData();
}


class WeatherDays implements WeatherRepo {

  DatabaseHelper helper = DatabaseHelper();
  List<Weather> _weatherDay = [];

  List<Weather> get items {
    return [..._weatherDay];
  }

  Future<WeatherState> fetchWeatherData() async {
    WeatherState weatherState;
    String errorMsg;
    try {
      var days = [
        'Sundey',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday'
      ];
      int index = -1;
      const url =
          "https://samples.openweathermap.org/data/2.5/forecast/daily?q=M%C3%BCnchen,DE&appid=b6907d289e10d714a6e88b30761fae22";
      final response = await http.get(url);
      final extractedData = (json.decode(response.body))['list'] as List<dynamic>;
      final List<Weather> _loadedWeatherDate = [];
    //  debugPrint(extractedData.length.toString());
      if (extractedData.length != 0) {
        extractedData.forEach((element) {
          element['dt'] = days[++index];
          _loadedWeatherDate.add(Weather.fromMap(element));
        });
        _weatherDay = _loadedWeatherDate;
        var numberOfRow = await helper.getCount();
        if (numberOfRow == 0) {
          await saveDataToSql();
        }
        weatherState = WeatherSuccess(_weatherDay);
      } else {
        errorMsg = "SomeThing Went Wrong Try again Later";
        weatherState = WeatherFailure(errorMsg);
      }
    } catch (error) {
      errorMsg = "SomeThing Went Wrong Try again Later";
      weatherState = WeatherFailure(errorMsg);
    }
    return weatherState;
  }

  Future<WeatherState> fetchData() async {
    var connenctionResult = await (Connectivity().checkConnectivity());
    if (connenctionResult == ConnectivityResult.mobile ||
        connenctionResult == ConnectivityResult.wifi) {
      return fetchWeatherData();
    } else if (connenctionResult == ConnectivityResult.none) {
      return getDataFromSql();
    }
  }

  Future<void> saveDataToSql() async {
    await helper.saveItem(_weatherDay);
  }

  Future<WeatherState> getDataFromSql() async {
    String errorMsg;
    WeatherState weatherState;
    try {
      var result = await helper.getItems();
      List<Weather> loadedWeather = [];
      result.forEach((element) {
        loadedWeather.add(Weather.fromSql(element));
      });
      _weatherDay = loadedWeather;
      weatherState = WeatherSuccess(_weatherDay);
    } catch (error) {
      errorMsg = "SomeThing Want Wrong try again Later";
      weatherState = WeatherFailure(errorMsg);
    }
    return weatherState;
  }

}
