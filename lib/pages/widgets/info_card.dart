import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InformationCard extends StatelessWidget {
  InformationCard({
    Key? key,
    required this.humidity,
    required this.unIndex,
    required this.wind,
  }) : super(key: key);

  int humidity;
  double wind;
  double unIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 100,
          height: 150,
          color: const Color.fromARGB(18, 255, 255, 255),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            color: Color.fromARGB(30, 255, 255, 255)))),
                width: 110,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://cdn-icons-png.flaticon.com/512/2938/2938122.png",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Humidity",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$humidity%",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(139, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Color.fromARGB(30, 255, 255, 255),
                    ),
                  ),
                ),
                width: 120,
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://i.pinimg.com/originals/53/22/c2/5322c2cad533e12e552d0dfdc89b4c25.png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "UV",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$unIndex",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(139, 255, 255, 255),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 110,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Wind",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$wind km/h",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(139, 255, 255, 255),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
