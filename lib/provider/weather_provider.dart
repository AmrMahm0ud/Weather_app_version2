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
       var days = ['Sundey' , 'Monday' , 'Tuesday' , 'Wednesday' , 'Thursday' , 'Friday' , 'Saturday'];
       int index= -1;
      const url =
          "https://samples.openweathermap.org/data/2.5/forecast/daily?q=M%C3%BCnchen,DE&appid=b6907d289e10d714a6e88b30761fae22";
      final response = await http.get(url);
//      await Future.delayed(Duration(seconds: 2),(){
//        print("sdas");
//      });
      final extractedData = (json.decode(response.body))['list'] as List<dynamic>;
      final List<Weather> _loadedWeatherDate = [];

      extractedData.forEach((element) {
        element['dt'] = days[++index];
        _loadedWeatherDate.add(Weather.fromMap(element));
      });
      _weatherDay = _loadedWeatherDate;
       notifyListeners();
       var numberOfRow = await helper.getCount();
       if(numberOfRow == 0) {
         debugPrint("hey");
         await saveDataToSql();
       }
       await getDataFromSql();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> saveDataToSql() async {
    await helper.saveItem(_weatherDay);
  }

  Future<void> getDataFromSql() async{
   var result = await helper.getItems();
   List<Weather> loadedWeather = [];
    result.forEach((element) {
      loadedWeather.add(Weather.fromSql(element));
    });
    _weatherDay = loadedWeather;
    notifyListeners();
  }


}


