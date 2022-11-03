import 'package:flutter/material.dart';
import 'package:weather_app/color/colors.dart';
import 'package:weather_app/models/weather_api.dart';
import 'package:weather_app/pages/loading/loading_page.dart';
import 'package:weather_app/services/weather_services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  WeatherService weatherService = weatherService();
  Weather weather = Weather();
  String image = '';
  Color defaultColor = Colors.black;
  int hour = 0;
  bool isday = false;
  bool isNight = false;
  String icon = '';
  Future getWeather() async{
    weather = await weatherService.getWeatherData();
    setState(() {
      getWeather();
      _isLoading = false;

    });
  }
  void setday() async{
    List dateTime = weather.date.split(' ');
    var hours = dateTime[1].split(':');
    var turnInt = int.parse(hours[0]);
    if(turnInt >= 19 || turnInt <= 5){
      print(turnInt);
      setState(() {
        isNight = true;
        defaultColor = nightappbarColor;
      });
    }
    if(turnInt > 5 && turnInt<19){
      setState(() {
        isNight =false;
        isday =true;
        defaultColor =dayappbarColor; 
      });
    }
  }
  void day() async{
    
  }
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) => _isLoading ? LoadingPage() : Scaffold();
}
