import 'dart:async';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/color/colors.dart';
import 'package:weather_app/core/icon/icons.dart';
import 'package:weather_app/models/weather_api.dart';
import 'package:weather_app/pages/loading/loading_page.dart';
import 'package:weather_app/pages/widgets/fore_cast.dart';
import 'package:weather_app/pages/widgets/header.dart';
import 'package:weather_app/pages/widgets/info_card.dart';
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
  String time = "";
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
    if (weather.text == 'Overcast') {
      setState(() {
        loadingIcon = overcastDayIcon;
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
    // print(datetime[0]);
    var hours = datetime[1].split(':');
    final time12 =
        DateFormat.jm().format(DateFormat("hh:mm").parse(datetime[1]));
    // var time12 = dateFormat.format(
    //   DateTime.parse(
    //     weather.date.toString(),
    //   ),
    // );
    print(time12);
    var turnInt = int.parse(hours[0]);
    setState(() {
      hour = turnInt;
      time = time12;
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
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      await weatherService.getWeatherData();
      _isLoading = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => _isLoading
      ? const LoadingPage()
      : Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(320),
            child: Header(
              date: weather.date.split(" ")[0],
              time: time,
              backgroundColor: defaultColor,
              cityName: weather.city,
              decription: weather.text,
              decriptionIMG: loadingIcon,
              stateName: weather.state,
              temp: weather.temp,
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: isday
                        ? LinearGradient(
                            begin: const Alignment(-1.5, 8),
                            end: const Alignment(-1.5, -0.5),
                            colors: [Colors.white, defaultColor],
                          )
                        : LinearGradient(
                            begin: const Alignment(-1.5, 8),
                            end: const Alignment(-1.5, -0.5),
                            colors: [Colors.white, defaultColor],
                          )),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        color: const Color.fromARGB(0, 255, 255, 255),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: weather.forcast.length - hour - 1,
                          itemBuilder: (context, index) =>
                              SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 5),
                            child: Center(
                                child: ForecastCard(
                              avergeTemp:
                                  weather.forcast[hour + index]['temp_c'] ?? "",
                              hour: weather.forcast[hour + index]['time']
                                  .toString()
                                  .split(" ")[1],
                              descriptionIMG: weather.forcast[hour + index]
                                      ['condition']['icon']
                                  .toString()
                                  .replaceAll('//', 'http://'),
                              descriptions: weather.forcast[hour + index]
                                      ['condition']['text'] ??
                                  "",
                            )),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: InformationCard(
                        humidity: weather.humditiy,
                        unIndex: weather.uvIndex,
                        wind: weather.wind,
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "©ANCODER",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
}
