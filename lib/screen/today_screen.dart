import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_verion2/screen/seven_days.dart';
import 'package:weather_app_verion2/weather_bloc/bloc.dart';
import 'package:weather_app_verion2/weather_bloc/weather_event.dart';
import 'package:weather_app_verion2/weather_bloc/weather_state.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context)..add(GetTodayWeather());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {

              if (state is WeatherLoading) {
                return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: CircularProgressIndicator()));
              } else if (state is WeatherFailure) {
                return Center(child:
                Padding(
                  padding: const EdgeInsets.only(top:240),
                  child: Text(state.message ,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  ),
                  ),
                )
                );
              } else if (state is WeatherSuccess) {
                return Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                  child :Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "SunDay",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${state.weatherList[0].temp.toStringAsFixed(0)} \u2103',
                            //'${weather.items[0].temp}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        state.weatherList[0].state == 'Clear'
                            ? Image.asset('assets/clear.png')
                            : state.weatherList[0].state == 'Snow'
                                ? Image.asset('assets/snow.png')
                                : Image.asset('assets/rainy.png'),
                      ],
                    ),
                );
              }
              return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CircularProgressIndicator()));
            },
          ),
          Center(
            child: Container(
                child: Center(
              child: FlatButton.icon(
                icon: Icon(Icons.calendar_today),
                label: Text("Next Seven Days"),
                color: Colors.red,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NextDays()));
                },
              ),
            )),
          ),
        ],
      ),
    );
  }
}
