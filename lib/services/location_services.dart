import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/location_model.dart';
import 'package:weather_app/providers/location_provider.dart';

class LocationServices {
  getLocation({required BuildContext context}) async {
    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    LocationModel locationModel = LocationModel();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        log('Permission Denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);
    LocationModel newLoc = locationModel.copyWith(
        longitude: position.longitude.toString(),
        latitude: position.latitude.toString());
    locationProvider.setLocationFromModel(newLoc);
    prefs.setString('latitude', position.latitude.toString());
    prefs.setString('longitude', position.longitude.toString());
    prefs.setString('city', locationProvider.locationModel.city.toString());
    log(locationProvider.locationModel.latitude.toString());
    log(position.latitude.toString());
  }
}
