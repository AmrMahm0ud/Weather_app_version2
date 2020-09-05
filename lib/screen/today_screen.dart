import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text("SunDay"),
              Text("temp"),
              Text("image"),
              ],
            ),
          ),
          Column(
            children: [
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Image.asset('clear.png'),
                  ),
                  title: Text("Sunny"),
                  trailing: Text("Date"),
                  subtitle: Text("temp"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
