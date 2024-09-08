import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeatherHomeWidget extends StatelessWidget {
  final String dateNow;
  final String temperature;
  final String wind;
  final String hum;
  final String weatherCode;
  const WeatherHomeWidget(
      {super.key,
      required this.dateNow,
      required this.temperature,
      required this.wind,
      required this.hum,
      required this.weatherCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 17, bottom: 17),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.white),
          color: const Color.fromRGBO(255, 255, 255, 0.3)),
      child: Column(
        children: [
          Text(
            dateNow,
            style: const TextStyle(
                fontFamily: 'Overpass',
                fontSize: 18,
                color: Colors.white,
                shadows: [
                  Shadow(
                      offset: Offset(-2, 3),
                      blurRadius: 1,
                      color: Color.fromRGBO(0, 0, 0, 0.1)),
                  Shadow(
                      offset: Offset(-1, 1),
                      blurRadius: 2,
                      color: Color.fromRGBO(255, 255, 255, 0.25)),
                ]),
          ),
          const SizedBox(height: 16),
          Center(
            child: RichText(
              text: TextSpan(
                text: temperature,
                style: const TextStyle(
                    fontFamily: 'Overpass',
                    fontSize: 100,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          offset: Offset(-6, 4),
                          blurRadius: 4,
                          color: Color.fromRGBO(255, 255, 255, 0.25)),
                      Shadow(
                          offset: Offset(2, -3),
                          blurRadius: 6,
                          color: Color.fromRGBO(0, 0, 0, 0.25)),
                      Shadow(
                          offset: Offset(-4, 8),
                          blurRadius: 50,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ]),
                children: const [
                  TextSpan(
                    text: '°',
                    style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 84,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              offset: Offset(-6, 4),
                              blurRadius: 4,
                              color: Color.fromRGBO(255, 255, 255, 0.25)),
                          Shadow(
                              offset: Offset(2, -3),
                              blurRadius: 6,
                              color: Color.fromRGBO(0, 0, 0, 0.25)),
                          Shadow(
                              offset: Offset(-4, 8),
                              blurRadius: 50,
                              color: Color.fromRGBO(0, 0, 0, 1)),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            weatherCode,
            style: const TextStyle(
                fontFamily: 'Overpass',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                      offset: Offset(-2, 3),
                      blurRadius: 1,
                      color: Color.fromRGBO(0, 0, 0, 0.1)),
                  Shadow(
                      offset: Offset(-1, 1),
                      blurRadius: 2,
                      color: Color.fromRGBO(255, 255, 255, 0.25)),
                ]),
          ),
          const SizedBox(height: 27),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/windy.svg',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Wind',
                style: TextStyle(
                    fontFamily: 'Overpass',
                    fontSize: 18,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          offset: Offset(-2, 3),
                          blurRadius: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.1)),
                      Shadow(
                          offset: Offset(-1, 1),
                          blurRadius: 2,
                          color: Color.fromRGBO(255, 255, 255, 0.25)),
                    ]),
              ),
              const SizedBox(width: 8),
              const Text(
                '|',
                style: TextStyle(
                    fontFamily: 'Overpass',
                    fontSize: 18,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          offset: Offset(-2, 3),
                          blurRadius: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.1)),
                      Shadow(
                          offset: Offset(-1, 1),
                          blurRadius: 2,
                          color: Color.fromRGBO(255, 255, 255, 0.25)),
                    ]),
              ),
              const SizedBox(width: 8),
              Text(
                '$wind km/h',
                style: const TextStyle(
                    fontFamily: 'Overpass',
                    fontSize: 18,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          offset: Offset(-2, 3),
                          blurRadius: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.1)),
                      Shadow(
                          offset: Offset(-1, 1),
                          blurRadius: 2,
                          color: Color.fromRGBO(255, 255, 255, 0.25)),
                    ]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/hum.svg',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Hum',
                style: TextStyle(
                    fontFamily: 'Overpass',
                    fontSize: 18,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          offset: Offset(-2, 3),
                          blurRadius: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.1)),
                      Shadow(
                          offset: Offset(-1, 1),
                          blurRadius: 2,
                          color: Color.fromRGBO(255, 255, 255, 0.25)),
                    ]),
              ),
              const SizedBox(width: 8),
              const Text(
                '|',
                style: TextStyle(
                    fontFamily: 'Overpass',
                    fontSize: 18,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          offset: Offset(-2, 3),
                          blurRadius: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.1)),
                      Shadow(
                          offset: Offset(-1, 1),
                          blurRadius: 2,
                          color: Color.fromRGBO(255, 255, 255, 0.25)),
                    ]),
              ),
              const SizedBox(width: 8),
              Text(
                '$hum %',
                style: const TextStyle(
                    fontFamily: 'Overpass',
                    fontSize: 18,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          offset: Offset(-2, 3),
                          blurRadius: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.1)),
                      Shadow(
                          offset: Offset(-1, 1),
                          blurRadius: 2,
                          color: Color.fromRGBO(255, 255, 255, 0.25)),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
