import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ummu_driweather/app/modules/home/controllers/home_controller.dart';

import '../../../data/service/api_client.dart';
import '../../../widgets/next_forecast_widget.dart';

class WeatherDetailsView extends GetView<HomeController> {
  const WeatherDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String dateNow = DateFormat('MMM, d').format(DateTime.now()).toString();

    return Scaffold(body: SingleChildScrollView(
      child: Obx(() {
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
          return Container(
            padding:
                const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 36),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Color.fromRGBO(71, 191, 223, 1),
                  Color.fromRGBO(74, 145, 255, 1)
                ])),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.chevron_left, size: 18, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        'Back',
                        style: TextStyle(
                            fontFamily: 'Overpass',
                            fontSize: 18,
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
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                _todayForecast(dateNow),
                const SizedBox(height: 40),
                _nextForecast(context),
                const SizedBox(height: 50),
                _watermark()
              ],
            ),
          );
        }
      }),
    ));
  }

  Widget _todayForecast(String dateNow) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Today',
              style: TextStyle(
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
            )
          ],
        ),
        const SizedBox(height: 30),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 200, // Set the desired height for the list
          ),
          child: Obx(() {
            // Periksa apakah data hourlyWeather sudah ada
            if (controller.hourlyWeather.value.data.timelines.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            // Ambil data cuaca per jam dari controller
            final hourlyData =
                controller.hourlyWeather.value.data.timelines[0].intervals;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: hourlyData
                  .length, 
              itemBuilder: (context, index) {
                final item = hourlyData[index];

                // Konversi startTime dari String ke DateTime
                DateTime dateTime =
                    DateTime.parse(item.startTime.toIso8601String());
                String hour =
                    "${dateTime.hour.toString().padLeft(2, '0')}.${dateTime.minute.toString().padLeft(2, '0')}";

                // Cek apakah item ini adalah waktu saat ini
                bool isNow = DateTime.now().hour == dateTime.hour;

                // Ambil weatherCode
                int weatherCodeHourly = item.values.weatherCode;
                String weatherCodeNameHourly =
                    ApiClient.handleWeatherCode(weatherCodeHourly);

                // Ambil ikon cuaca
                String weatherCodeIcon =
                    ApiClient.handleWeatherIcon(weatherCodeNameHourly);

                // Konversi suhu dari Fahrenheit ke Celsius
                double temperatureFahrenheit = item.values.temperature;
                String tempListHourly =
                    ((temperatureFahrenheit - 32) * 5 / 9).toStringAsFixed(0);

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isNow
                        ? const Color.fromRGBO(255, 255, 255, 0.3)
                        : Colors.transparent, // Warna background untuk saat ini
                    borderRadius: BorderRadius.circular(20.0),
                    border: isNow
                        ? Border.all(
                            color: const Color.fromRGBO(255, 255, 255, 0.2),
                            width: 2,
                          )
                        : null,
                    boxShadow: isNow
                        ? [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Menampilkan suhu dalam derajat Celcius
                      Text(
                        '$tempListHourly°C',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      SvgPicture.asset(
                        weatherCodeIcon,
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(height: 8),
                      // Menampilkan waktu dalam format "HH.mm"
                      Text(
                        hour,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        )
      ],
    );
  }

  Widget _nextForecast(BuildContext context) {
    final dateWeather =
                controller.weather.value.data.timelines[0].intervals;
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Next Forecast',
              style: TextStyle(
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
            Icon(
              Icons.date_range_outlined,
              color: Colors.white,
              size: 24,
              shadows: [
                Shadow(
                    offset: Offset(-2, 3),
                    blurRadius: 1,
                    color: Color.fromRGBO(0, 0, 0, 0.1)),
                Shadow(
                    offset: Offset(-1, 1),
                    blurRadius: 2,
                    color: Color.fromRGBO(255, 255, 255, 0.25)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Scrollbar(
            controller: controller.scrollController,
            thickness: 5,
            thumbVisibility: true,
            child: ListView.builder(
              controller: controller.scrollController,
              shrinkWrap: true,
              itemCount: dateWeather.length,
              itemBuilder: (context, index) {
                // Ambil data berdasarkan index
                String date = controller.weather.value.data.timelines[0]
                    .intervals[index].startTime
                    .toString();

                // Format tanggal bualn, hari
                DateTime dateTime = DateTime.parse(date);
                String formattedDate = DateFormat('MMM, d').format(dateTime);

                // weatherCode
                int weatherCode = controller.weather.value.data.timelines[0]
                    .intervals[index].values.weatherCode;
                String weatherCodeName =
                    ApiClient.handleWeatherCode(weatherCode);

                // weather icon
                String weatherCodeIcon =
                    ApiClient.handleWeatherIcon(weatherCodeName);

                // suhu dari Fahrenheit ke Celsius
                double temperatureFahrenheit = controller.weather.value.data
                    .timelines[0].intervals[index].values.temperature;
                String tempList =
                    ((temperatureFahrenheit - 32) * 5 / 9).toStringAsFixed(0);

                // Print hasil untuk debugging
                print('Data List: $formattedDate, $weatherCodeIcon, $tempList');

                // return widget NextForecastWidget untuk setiap item dalam ListView
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 20),
                  child: NextForecastWidget(
                    date: formattedDate,
                    iconData: weatherCodeIcon,
                    temperature: tempList,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _watermark() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/sun_small.svg',
          width: 24,
          height: 24,
          color: Colors.white,
        ),
        const SizedBox(width: 14),
        const Text(
          'DRI Weather',
          style: TextStyle(
              fontFamily: 'Overpass',
              fontSize: 18,
              fontWeight: FontWeight.w400,
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
    );
  }
}
