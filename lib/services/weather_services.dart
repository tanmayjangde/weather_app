import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class WeatherService {
  final String apiKey = '7b90b0eaa07b65a1ff1138de3bb4aa27';

  Future<Map<String, dynamic>> getWeather(String cityName) async {
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> fetchWeather() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lat = position.latitude, lon = position.longitude;
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
