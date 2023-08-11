import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  String apiKey = 'a233b153291f47f38db115231230608';
  String baseUrl = 'api.weatherapi.com';
  String endPoint = '/v1/forecast.json';

  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weatherModel;
    try {
      Uri url = Uri.http(baseUrl, endPoint, {'key': apiKey, 'q': cityName});
      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);
      weatherModel = WeatherModel.fromJson(data);
    } catch (e) {}
    return weatherModel;
  }
}
