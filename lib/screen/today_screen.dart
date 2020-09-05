import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_verion2/model/weather_model.dart';
import 'package:weather_app_verion2/provider/weather_provider.dart';
import 'package:weather_app_verion2/screen/seven_days.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    //List<Weather> _weatherday = Provider.of<WeatherDays>(context).items;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder(
            future: Provider.of<WeatherDays>(context, listen: false)
                .fetchWeatherData(),
            builder: (ctx, snapShot) =>
                snapShot.connectionState == ConnectionState.waiting
                    ? Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.red,
                        child: Consumer<WeatherDays>(
                          builder: (ctx, weather, _) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                //child: Text('${weather.items[0].date}',
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
                                  '${weather.items[0].temp}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              weather.items[0].state == 'Clear'
                                  ? Image.asset('assets/clear.png')
                                  : weather.items[0].state == 'Snow'
                                      ? Image.asset('assets/snow.png')
                                      : Image.asset('assets/rainy.png'),
                            ],
                          ),
                        ),
                      ),
          ),
              Center(
                child: Container(
                      child:Center(
                        child: FlatButton.icon(
                          icon: Icon(Icons.calendar_today),
                          label: Text("Next Seven Days"),
                          color: Colors.red,
                          onPressed: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => NextDays()));
                          },
                        ),
                      )
                    ),
              ),
        ],
      ),
    );
  }
}
