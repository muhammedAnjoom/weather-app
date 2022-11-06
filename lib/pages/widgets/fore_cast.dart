import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ForecastCard extends StatelessWidget {
   ForecastCard({
    Key? key,
    required this.hour,
    required this.avergeTemp,
    required this.descriptionIMG,
    required this.descriptions,
  }) : super(key: key);
  String hour;
  String descriptions;
  String descriptionIMG;
  double avergeTemp;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(18, 255, 255, 255)
      ),
      child: Column(
        children: [
          Text(hour,style:const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600
          ),),
          const SizedBox(height: 10,),
          Container(
            height: 70,
            width: 70,
            color: const Color.fromARGB(0, 0, 0, 0),
          )
        ],
      ),
    );
  }
}
