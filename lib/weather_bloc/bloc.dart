import 'package:bloc/bloc.dart';
import 'package:weather_app_verion2/weather_bloc/weather_event.dart';
import 'package:weather_app_verion2/weather_bloc/weather_repo.dart';
import 'package:weather_app_verion2/weather_bloc/weather_state.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
      WeatherEvent event,
      ) async* {
    if (event is GetSevenDaysWeather) {
      yield WeatherLoading();
      yield await weatherRepository.fetchData();
    }
    else if (event is GetTodayWeather) {
      yield WeatherLoading();
      yield await weatherRepository.fetchData();
    }
  }
}
