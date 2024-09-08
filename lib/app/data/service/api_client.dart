import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../modules/maps/controllers/maps_controller.dart';
import '../models/weather_model.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://api.tomorrow.io/v4",
  ));

  //replace with your ApiKEY
  static const String apiKey = 'YOUR_API_KEY';

  //pick a location to get the weather
  // Get the MapsController instance
  final MapsController _mapsController = Get.find<MapsController>();
  static const location = [40.758, -73.9855]; //New York

  //// list the fields you want to get from the api
  static const fields = [
    "windSpeed",
    "windDirection",
    "temperature",
    "temperatureApparent",
    "weatherCode",
    "humidity",
    "visibility",
    "dewPoint",
    "cloudCover",
    "precipitationType"
  ];

  // choose the unit system, either metric or imperial
  static const units = "imperial";

  // set the timesteps, like "current" and "1d"
  static const timesteps = ["current", "1d"];

  // configure the time frame up to view the current and 4-days weather forecast
  String startTime =
      DateTime.now().toUtc().add(const Duration(minutes: 0)).toIso8601String();

  String endTime =
      DateTime.now().toUtc().add(const Duration(days: 4)).toIso8601String();

  //method to get the weather data
  Future<Weather> getWeather() async {
    try {
      final double lat = _mapsController.lat1.value;
      final double long = _mapsController.long1.value;

      final response = await _dio.get('/timelines', queryParameters: {
        'location': '$lat,$long',
        'apikey': apiKey,
        'fields': fields,
        'units': units,
        'timesteps': ["current", "1d"],
        'startTime': startTime,
        'endTime': endTime
      });

      //parse the JSON data, returns the Weather data
      print('Weather Data ${response.data}');
      return Weather.fromJson(response.data);
    } on DioError catch (e) {
      //returns the error if any
      return e.response!.data;
    }
  }

  // Method to get hourly weather data
  Future<Weather> getHourlyWeather() async {
    try {
      final double lat = _mapsController.lat1.value;
      final double long = _mapsController.long1.value;

      final response = await _dio.get('/timelines', queryParameters: {
        'location': '$lat,$long',
        'apikey': apiKey,
        'fields': fields,
        'units': units,
        'timesteps': ["1h"], // Specifically for hourly data
        'startTime': startTime,
        'endTime': endTime
      });

      // Parse the JSON data for hourly weather
      print('Hourly Weather Data ${response.data}');
      return Weather.fromJson(response.data);
    } on DioError catch (e) {
      // Return the error if any
      return e.response!.data;
    }
  }

  static String handleWeatherCode(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return "Unknown";
      case 1000:
        return 'Sunny';
      case 1100:
        return 'Mostly Clear';
      case 1101:
        return 'Partly Cloudy';
      case 1102:
        return 'Mostly Cloudy';
      case 1001:
        return 'Cloudy';
      case 2000:
        return 'Fog';
      case 4200:
        return 'Light Rain';
      case 6200:
        return 'Light Freezing Rain';
      default:
        return 'Unknown';
    }
  }

  static String handleWeatherIcon(String weatherCodeName) {
    switch (weatherCodeName) {
      case 'Sunny':
        return "assets/icons/sun.svg";
      case 'Mostly Clear':
        return 'assets/icons/cloud_full.svg';
      case 'Partly Cloudy':
        return 'assets/icons/cloud.svg';
      case 'Mostly Cloudy':
        return 'assets/icons/cloudy.svg';
      case 'Cloudy':
        return 'assets/icons/cloud.svg';
      case 'Fog':
        return 'assets/icons/cloudy.svg';
      case 'Light Rain':
        return 'assets/icons/cloud.svg';
      case 'Light Freezing Rain':
        return 'assets/icons/cloud.svg';
      default:
        return '';
    }
  }
}
