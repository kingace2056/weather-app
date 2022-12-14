import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants/url_constants.dart';
import 'package:weather_app/model/weather_model.dart';

import 'package:http/http.dart' as http;
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/location_services.dart';

class WeatherServices extends ChangeNotifier {
  getWeatherDetail({required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocationServices locationServices = LocationServices();
    await locationServices.getLocation(context: context);
    String? city = prefs.getString('city');
    String? latitude = prefs.getString('latitude');
    String? longitude = prefs.getString('longitude');

    var weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    try {
      if (city == null || city == 'null' || city == '') {
        log('chkPoint 1 ');
        var reqUri = Uri(
            scheme: 'https',
            host: baseUrl,
            path: '/v1/current.json',
            queryParameters: {
              'key': '1bc0383d81444b58b1432929200711',
              'q': '$latitude,$longitude'
            });
        http.Response response = await http.get(reqUri);
        log('chkPoint 2 ');
        weatherProvider.setWeather(response.body);
        notifyListeners();
        log('chkPoint 3');
      } else {
        log('chkPoint 4 ');
        var reqUri = Uri(
            scheme: 'https',
            host: baseUrl,
            path: '/v1/current.json',
            queryParameters: {
              'key': '1bc0383d81444b58b1432929200711',
              'q': prefs.getString('city')
            });
        log('chkPoint 5 ');
        http.Response response = await http.get(reqUri);
        log('chkPoint 6 ');
        log(response.body.toString());
        weatherProvider.setWeather(response.body);
        log('chkPoint 7 ');
        notifyListeners();
      }

      notifyListeners();
    } catch (e) {
      log('Woops error');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sorry, Couldnt find location')));
      log(e.toString());
    }
  }
}
