import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              WeatherModel? weatherModel =
                  await WeatherService().getWeather(cityName: data);
              // ignore: use_build_context_synchronously
              Provider.of<WeatherProvider>(context, listen: false).weatherData =
                  weatherModel;
              // ignore: use_build_context_synchronously
              Provider.of<WeatherProvider>(context, listen: false).cityName =
                  data;
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () async {
                  WeatherModel? weatherModel =
                      await WeatherService().getWeather(cityName: cityName!);
                  // ignore: use_build_context_synchronously
                  Provider.of<WeatherProvider>(context, listen: false)
                      .weatherData = weatherModel;
                  // ignore: use_build_context_synchronously
                  Provider.of<WeatherProvider>(context, listen: false)
                      .cityName = cityName;
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: const Icon(Icons.search),
              ),
              label: const Text('search'),
              hintText: 'Enter a City',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
            ),
          ),
        ),
      ),
    );
  }
}
