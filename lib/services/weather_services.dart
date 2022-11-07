import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants/url_constants.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/providers/location_provider.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/location_services.dart';

class WeatherServices {
  getWeatherDetail({required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? city = prefs.getString('city');
    String? latitude = prefs.getString('latitude');
    String? longitude = prefs.getString('longitude');
    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    try {
      if (city == null || city == 'null' || city == '') {
        await LocationServices().getLocation(context: context);

        var reqUri = Uri(
            scheme: 'https',
            host: baseUrl,
            path: '/v1/current.json',
            queryParameters: {
              'key': '1bc0383d81444b58b1432929200711',
              'q': '$latitude,$longitude'
            });
        http.Response response = await http.get(reqUri);
        return weatherModelFromJson(response.body);
        log(response.body.toString());
      } else {
        var reqUri = Uri(
            scheme: 'https',
            host: baseUrl,
            path: '/v1/current.json',
            queryParameters: {
              'key': '1bc0383d81444b58b1432929200711',
              'q': prefs.getString('city')
            });
        http.Response response = await http.get(reqUri);
        log(response.body.toString());
        return weatherModelFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
