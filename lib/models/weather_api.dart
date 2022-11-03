class Weather {
  final String city;
  final double temp;
  final String text;
  final String date;
  final String state;
  final int humditiy;
  final double uvIndex;
  final double wind;
  final List forcast;

  Weather({
    this.city = '',
    this.temp = 0,
    this.text = '',
    this.date = '',
    this.state = '',
    this.humditiy = 0,
    this.uvIndex = 0,
    this.wind = 0,
    this.forcast = const [],
  });
  factory Weather.fromJson(json) {
    return Weather(
      uvIndex: json['current']['uv'] ,
      city: json['location']['name'],
      date: json['location']['localtime'],
      forcast: json['forecast']['forecastday'][0]['hour'],
      humditiy: json['current']['humidity'],
      state: json['location']['region'],
      temp: json['current']['temp_c'],
      text: json['current']['condition']['text'],
      wind: json['current']['wind_kph'],
    );
  }
}
