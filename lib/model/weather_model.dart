
class Weather {
  double temp ;
  String state;
  DateTime date ;
  Weather(this.date , this.temp , this.state);

  Weather.fromMap(Map<String , dynamic> weatherFromMap){
    this.temp = weatherFromMap['temp']['max'];
    this.state = weatherFromMap['weather'][0]['main'];
    this.date = DateTime.fromMicrosecondsSinceEpoch(weatherFromMap['dt']);
  }
}