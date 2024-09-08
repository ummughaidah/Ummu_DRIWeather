import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ummu_driweather/app/modules/home/views/weather_details_view.dart';
import 'package:ummu_driweather/app/modules/maps/views/maps_view.dart';
import 'package:ummu_driweather/app/widgets/item_notification_widget.dart';

import '../../../data/service/api_client.dart';
import '../../../widgets/button_custom.dart';
import '../../../widgets/weather_home_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(body: Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.errorMessage.isNotEmpty) {
        return Center(
          child: Text(
            'Error: ${controller.errorMessage.value}',
            style: const TextStyle(color: Colors.red),
          ),
        );
      } else {
        //when the future is complete and has no error, show the weather
        int weatherCode = controller
            .weather.value.data.timelines[1].intervals[0].values.weatherCode;
        //weatherName
        String weatherCodeName = ApiClient.handleWeatherCode(weatherCode);
        //weatherIcon
        String weatherCodeIcon = ApiClient.handleWeatherIcon(weatherCodeName);

        String convertTemp = ((controller.weather.value.data.timelines[0]
                        .intervals[0].values.temperature -
                    32) *
                5 /
                9)
            .toStringAsFixed(0);
        String wind = controller
            .weather.value.data.timelines[0].intervals[0].values.windSpeed
            .toStringAsFixed(0);
        String hum = controller
            .weather.value.data.timelines[0].intervals[0].values.humidity
            .toStringAsFixed(0);
        String dateNow =
            DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()).toString();

        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Color.fromRGBO(71, 191, 223, 1),
                Color.fromRGBO(74, 145, 255, 1)
              ])),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 36),
            child: Column(
              children: [
                _appBar(),
                const SizedBox(height: 66),
                _iconCloud(weatherCodeIcon),
                const SizedBox(height: 34),
                WeatherHomeWidget(
                  dateNow: dateNow,
                  temperature: convertTemp,
                  wind: wind,
                  hum: hum,
                  weatherCode: weatherCodeName,
                ),
                const SizedBox(height: 100),
                _buttonWeatherDetails()
              ],
            ),
          ),
        );
      }
    }));
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.to(() => const MapsView());
          },
          child: const Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 30,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text('Semarang',
                  style: TextStyle(
                      fontFamily: 'Overpass',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(width: 8),
              Icon(
                Icons.expand_more,
                color: Colors.white,
              )
            ],
          ),
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none,
                  size: 32, color: Colors.white),
              onPressed: () {
                // Get.dialog(_alertNotif());
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 100,
                              height: 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          _bottomSheettNotif(),
                        ],
                      ),
                    ),
                  ),
                  isDismissible: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              right: 15,
              top: 15,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 7,
                  minHeight: 7,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _iconCloud(String iconWeather) {
    return SvgPicture.asset(
      iconWeather,
      width: 170,
      height: 170,
    );
  }

  Widget _buttonWeatherDetails() {
    return SizedBox(
      width: 220,
      height: 64,
      child: ButtonCustom(
        onTap: () {
          Get.to(() => const WeatherDetailsView());
        },
        title: 'Weather Details',
        iconData: Icons.chevron_right,
        colorText: const Color.fromRGBO(68, 78, 114, 1),
        colorIcon: const Color.fromRGBO(68, 78, 114, 1),
        borderRadius: 20,
      ),
    );
  }

  Widget _bottomSheettNotif() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Notification',
          style: TextStyle(
            fontFamily: 'Overpass',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'New',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Overpass',
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return ItemNotificationWidget(
                  iconAsset: 'assets/icons/sun_small.svg',
                  subtitle:
                      'A sunny day in your location, consider wearing your UV protection',
                  onTap: () {},
                  day: '10 minute ago',
                  index: index,
                  currentIndex:
                      controller.currentNotificationSelectedIndex.value);
            }),
        const SizedBox(height: 8),
        const Text(
          'Earlier',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Overpass',
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return ItemNotificationWidget(
                  iconAsset: 'assets/icons/windy.svg',
                  subtitle:
                      'A sunny day in your location, consider wearing your UV protection',
                  onTap: () {},
                  day: '1 day ago',
                  index: 1,
                  currentIndex:
                      controller.currentNotificationSelectedIndex.value);
            })
      ],
    );
  }
}
