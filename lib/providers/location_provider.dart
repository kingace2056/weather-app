import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/location_model.dart';

class LocationProvider extends ChangeNotifier {
  LocationModel _locationModel =
      LocationModel(latitude: '', longitude: '', city: '');

  LocationModel get locationModel => _locationModel;
  void setLocationFromModel(LocationModel locationModel) {
    _locationModel = locationModel;
    notifyListeners();
  }
}
