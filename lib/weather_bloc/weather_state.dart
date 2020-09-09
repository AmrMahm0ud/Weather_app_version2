import 'package:weather_app_verion2/model/weather_model.dart';

abstract class WeatherState  {
  const WeatherState();
}


class WeatherInitial extends WeatherState {
  WeatherInitial();
}
//for loading state
class WeatherLoading extends WeatherState {
  WeatherLoading();

}
//for success auth state
class WeatherSuccess extends WeatherState {
  List<Weather> weatherList;
  WeatherSuccess(this.weatherList);

}

//for failure auth state
class WeatherFailure extends WeatherState {
  String message;
  WeatherFailure(this.message);

}
