

class Weather {
  double temp;
  String state;
  int date;
  Weather(this.date, this.temp, this.state);

  Weather.fromMap(Map<String, dynamic> weatherFromMap) {
    this.temp = weatherFromMap['temp']['max'];
    this.state = weatherFromMap['weather'][0]['main'];
    this.date=weatherFromMap['dt'];
   //this.date = DateTime.fromMicrosecondsSinceEpoch(weatherFromMap['dt']);
  }

   Map<String, dynamic> toMap(Weather obj) {
    var map = Map<String, dynamic>();
    map['State'] = obj.state;
    map['temp'] = obj.temp;
    map['dateCreated'] = obj.date;

    return map;
  }
}
