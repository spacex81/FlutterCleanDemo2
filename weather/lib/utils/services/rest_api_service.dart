import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather/modules/weather_screen/models/weather_model.dart';
import 'package:weather/utils/services/api_urls.dart';

class RestAPIService {
  // Singleton Class
  RestAPIService._internal();
  static final RestAPIService _serviceInstance = RestAPIService._internal();
  factory RestAPIService() => _serviceInstance;

  static int apiHitTimeout = 30;

  String apiKey = dotenv.get('API_KEY');

  Future<WeatherDataModel?> fetchCurrentWeatherDetails(
      {required String location}) async {
    final response = await http.get(
      Uri.parse(
        APIUrls.currentWeatherURL,
      ).replace(queryParameters: {
        'q': location,
        'key': apiKey,
      }),
    );

    if (response.statusCode == 200) {
      return WeatherDataModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      return null;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
