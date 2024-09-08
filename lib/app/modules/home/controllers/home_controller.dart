import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/models/weather_model.dart';
import '../../../data/service/api_client.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;

  // api client
  final ApiClient apiClient = ApiClient();

  // weather model
  var weather = Weather(
    data: Data(timelines: []),
    warnings: [],
  ).obs;

  // Weather model for hourly weather
  var hourlyWeather = Weather(
    data: Data(timelines: []),
    warnings: [],
  ).obs;

  var errorMessage = ''.obs;

  RxInt currentNotificationSelectedIndex = 0.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchWeather();
    fetchHourlyWeather();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  // Method to fetch weather data
  void fetchWeather() async {
    try {
      isLoading.value = true;
      Weather weatherData = await apiClient.getWeather();
      weather.value = weatherData;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Method to fetch hourly weather data
  void fetchHourlyWeather() async {
    try {
      isLoading.value = true;
      Weather hourlyWeatherData = await apiClient.getHourlyWeather();
      hourlyWeather.value = hourlyWeatherData;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
