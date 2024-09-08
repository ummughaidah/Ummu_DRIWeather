import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NextForecastWidget extends StatelessWidget {
  final String? date;
  final String? iconData;
  final String? temperature;
  const NextForecastWidget({
    super.key,
    this.date,
    this.iconData,
    this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date!,
          style: const TextStyle(
              fontFamily: 'Overpass',
              fontSize: 18,
              fontWeight: FontWeight.w700,
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
        SvgPicture.asset(
          iconData!,
          width: 60,
          height: 60,
        ),
        RichText(
            text: TextSpan(
                text: temperature,
                style: const TextStyle(
                    fontFamily: 'Overpass',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
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
                children: const [
              TextSpan(
                text: '°',
                style: TextStyle(
                    fontFamily: 'Overpass',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
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
            ])),
      ],
    );
  }
}
