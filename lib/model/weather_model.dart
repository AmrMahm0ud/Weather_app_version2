import 'dart:io';
import 'dart:math';

class Weather {
  double temp;
  String state;
  String date;
  Weather(this.date, this.temp, this.state);

  Weather.fromMap(Map<String, dynamic> weatherFromMap) {
    this.temp = weatherFromMap['temp']['max'] - 273.15;
    this.state = weatherFromMap['weather'][0]['main'];
    this.date=weatherFromMap['dt'];
   //this.date = DateTime.fromMicrosecondsSinceEpoch(weatherFromMap['dt']);
  }

   Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['State'] = this.state;
    map['temp'] = this.temp;
    map['dateCreated'] = this.date;

    return map;
  }

  Weather.fromSql(Map<String , dynamic> weatherFromSql){
    this.state = weatherFromSql['State'];
    this.temp = weatherFromSql['temp'];
    this.date = weatherFromSql['dateCreated'];
  }
}

