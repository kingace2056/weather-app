import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/weather_model.dart';

class LocProvider extends ChangeNotifier {
  Location _location = Location(
    name: '',
    region: '',
    country: '',
    lat: 0,
    lon: 0,
    tzId: '',
    localtimeEpoch: 0,
    localtime: '',
  );
  Location get location => _location;
  void setLocation(String location) {
    _location = Location.fromJson(jsonDecode(location));
    notifyListeners();
  }

  void setLocationFromModel(Location location) {
    _location = location;
    notifyListeners();
  }
}
