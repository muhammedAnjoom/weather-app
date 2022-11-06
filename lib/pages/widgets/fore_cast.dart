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
      height: 170,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(18, 255, 255, 255)),
      child: Column(
        children: [
          const SizedBox(height: 8,),
          Text(
            hour,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 70,
            width: 70,
            color: const Color.fromARGB(0, 0, 0, 0),
            child: Image.network(
              descriptionIMG,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "$avergeTemp",
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            descriptions,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromARGB(139, 255, 255, 255),
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
