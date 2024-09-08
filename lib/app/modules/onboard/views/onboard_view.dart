import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ummu_driweather/app/modules/home/views/home_view.dart';

import '../../../widgets/button_custom.dart';
import '../controllers/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromRGBO(74, 158, 247, 1),
              Color.fromRGBO(255, 255, 255, 1)
            ])),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // desain circle
              Obx(() => CustomPaint(
                    size: const Size(800, 800),
                    painter: CirclePainter(
                        Get.find<OnboardController>().circleRadius.value),
                  )),
              // Ikon SVG Sun
              Positioned(
                top: 66,
                left: -100,
                child: SvgPicture.asset(
                  'assets/icons/sun_full.svg',
                  width: 176,
                  height: 187,
                ),
              ),
              // Ikon SVG awan
              Positioned(
                top: 150,
                left: 60,
                child: SvgPicture.asset(
                  'assets/icons/cloud_full.svg',
                  width: 605,
                  height: 378,
                ),
              ),
              Positioned(
                bottom: 200,
                left: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Never get caught\nin the rain again',
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(73, 74, 75, 1),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Stay ahead of the weather with our\naccurate forecasts',
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 16,
                        color: Color.fromRGBO(73, 74, 75, 1),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 306,
                      height: 64,
                      child: ButtonCustom(
                        onTap: () {
                          Get.to(() => const HomeView());
                        },
                        title: 'Get Started',
                        colorText: const Color.fromRGBO(68, 78, 114, 1),
                        borderRadius: 20,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double radius;
  CirclePainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Define the center of the circle
    final center = Offset(size.width * 0.75, size.height * 0.25);

    // Draw concentric circles with increasing radius
    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, i * radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Agar repaint ketika radius berubah
  }
}
