import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_verion2/weather_bloc/bloc.dart';
import 'package:weather_app_verion2/weather_bloc/weather_event.dart';
import 'package:weather_app_verion2/weather_bloc/weather_state.dart';

class NextDays extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context)..add(GetSevenDaysWeather());
    return Scaffold(
      appBar: AppBar(
        title: Text("Seven Days Weather"),
        backgroundColor: Colors.red,
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Center(child: CircularProgressIndicator()));
          } else if (state is WeatherFailure) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 240),
              child: Text(
                state.message,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ));
          } else if (state is WeatherSuccess) {
           return ListView.builder(
              itemBuilder: (ctx, index) => Container(
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: state.weatherList[index].state == 'Clear'
                          ? Image.asset('assets/clear.png')
                          : state.weatherList[index].state == 'Snow'
                          ? Image.asset('assets/snow.png')
                          : Image.asset('assets/rainy.png'),
                    ),
                    title: Text("${state.weatherList[index].state}"),
                    trailing: Text("${state.weatherList[index].date}"),
                    subtitle: Text("${state.weatherList[index].temp.toStringAsFixed(0)} \u2103"),
                  ),
                ),
              ),
              itemCount: state.weatherList.length,
            );
          }
          return Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
