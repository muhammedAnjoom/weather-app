import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/core/icon/icons.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class Header extends StatefulWidget {
  Header({
    Key? key,
    required this.cityName,
    required this.decription,
    required this.decriptionIMG,
    required this.stateName,
    required this.backgroundColor,
    required this.temp,
    required this.date,
    required this.time
  }) : super(key: key);
  String cityName;
  String stateName;
  double temp;
  String decriptionIMG;
  String decription;
  String time;
  String date;
  Color backgroundColor;
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  WeatherService weatherService = WeatherService();
  TextEditingController textFiledController = TextEditingController();
  IconData textFiledIcon = Icons.clear;
  bool _isLoading = false;
  bool notFound = false;

  loadingFunction() async {
    await weatherService.getWeatherData();
    print(widget.cityName);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height / 3,
      backgroundColor: widget.backgroundColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            _isLoading
                ? Lottie.network(
                    rainyIcon,
                    height: 50,
                  )
                : SizedBox(
                    width: 700,
                    height: 50,
                    child: TextField(
                      controller: textFiledController,
                      onSubmitted: (value) {
                        setState(() {
                          _isLoading = true;
                          city = value;
                          Future.delayed(const Duration(seconds: 1), () {
                            loadingFunction();
                            textFiledController.clear();
                          });
                        });
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          suffix: IconButton(
                            icon: Icon(
                              textFiledIcon,
                            ),
                            onPressed: () {
                              textFiledController.clear();
                              FocusScope.of(context).unfocus();
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15,
                          ),
                          hintText: "Search for cities",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(133, 255, 255, 255),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(18, 255, 255, 255),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
            const SizedBox(
              height: 25,
            ),
            notFound
                ? const Text("not found")
                : Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              "${widget.temp.toString()}°",
                              style: const TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.w200),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.cityName,
                            style: const TextStyle(fontSize: 25),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.stateName,
                            style: const TextStyle(
                              letterSpacing: -1,
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            widget.date.split("-").reversed.join("-"),
                            style:const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            widget.time,
                            style:const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: 120,
                          child: Column(
                            children: [
                              Lottie.network(widget.decriptionIMG.toString(),
                                  fit: BoxFit.cover),
                              Text(widget.decription,textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
