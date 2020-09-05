import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/weather_model.dart';
import '../provider/weather_provider.dart';

class NextDays extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Weather> _weatherday = Provider.of<WeatherDays>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Saven Days Weather"),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => Container(
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                child: _weatherday[index].state == 'Clear'
                    ? Image.asset('assets/clear.png')
                    : _weatherday[index].state == 'Snow'
                    ? Image.asset('assets/snow.png')
                    : Image.asset('assets/rainy.png'),
              ),
              title: Text("${_weatherday[index].state}"),
              trailing: Text("${_weatherday[index].date}"),
              subtitle: Text("${_weatherday[index].temp}"),
            ),
          ),
        ),
        itemCount: _weatherday.length,
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
