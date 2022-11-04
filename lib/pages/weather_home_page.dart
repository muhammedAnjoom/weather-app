import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/core/color/colors.dart';
import 'package:weather_app/core/icon/icons.dart';
import 'package:weather_app/models/weather_api.dart';
import 'package:weather_app/pages/loading/loading_page.dart';
import 'package:weather_app/services/weather_services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  WeatherService weatherService = WeatherService();
  Weather weather = Weather();

  String image = '';
  Color defaultColor = Colors.black;
  int hour = 0;
  bool isday = false;
  bool isNight = false;
  String icon = '';
  bool _isLoading = true;

  Future getWeather() async {
    weather = await weatherService.getWeatherData();
    setState(() {
      getWeather();
      _isLoading = false;
    });
  }

  void setday() async {
    List datetime = weather.date.split(' ');
    var hours = datetime[1].split(':');
    var turnInt = int.parse(hours[0]);
    if (turnInt >= 19 || turnInt <= 5) {
      print(turnInt);
      setState(() {
        isday = false;
        isNight = true;
        defaultColor = nightappbarColor;
      });
    }
    if (turnInt > 5 && turnInt < 19) {
      setState(() {
        isNight = false;
        isday = true;
        defaultColor = dayappbarColor;
      });
    }
  }

  void day() async {
    setState(() {
      defaultColor = dayappbarColor;
    });
    if (weather.text == 'Sunny') {
      setState(() {
        loadingIcon = sunnyIcon;
      });
    }
    if (weather.text == 'Overcast') {
      setState(() {
        loadingIcon = overcastDayIcon;
      });
    }
    if (weather.text == 'Partly cloud') {
      setState(() {
        loadingIcon = partlyCloudDayIcon;
      });
    }
  }

  void night() async {
    setState(() {
      defaultColor = nightappbarColor;
    });

    if (weather.text == 'Partly Cloud') {
      setState(() {
        loadingIcon = partlyCloudyIconNight;
      });
    }
    if (weather.text == 'Clear') {
      setState(() {
        loadingIcon = clearNightIcon;
      });
    }
  }

  void gethour() {
    List datetime = weather.date.split(' ');
    var hours = datetime[1].split(':');
    var turnInt = int.parse(hours[0]);
    setState(() {
      hour = turnInt;
    });
  }

  @override
  void initState() {
    getWeather();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setday();
    });
    Timer.periodic(const Duration(seconds: 2), (timer) {
      isday ? day() : night();
    });
    Timer.periodic(const Duration(seconds: 2), (timer) {
      gethour();
    });
    Timer.periodic(const Duration(seconds: 2), (timer) async{
      await weatherService.getWeatherData();
      _isLoading=false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      _isLoading ? const LoadingPage() : const Scaffold();
}
