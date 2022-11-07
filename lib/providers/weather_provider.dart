import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel _weatherModel = WeatherModel(
      location: Location(
          name: '',
          region: '',
          country: '',
          lat: 0,
          lon: 0,
          tzId: '',
          localtimeEpoch: 0,
          localtime: ''),
      current: Current(
        lastUpdatedEpoch: 0,
        lastUpdated: '',
        tempC: 0,
        tempF: 0,
        isDay: 0,
        condition: Condition(code: 0, icon: '', text: ''),
        windMph: 0,
        windKph: 0,
        windDegree: 0,
        windDir: ' ',
        pressureMb: 0,
        pressureIn: 0,
        precipMm: 0,
        precipIn: 0,
        humidity: 0,
        cloud: 0,
        feelslikeC: 0,
        feelslikeF: 0,
        visKm: 0,
        visMiles: 0,
        uv: 0,
        gustMph: 0,
        gustKph: 0,
      ));
  WeatherModel get weatherModel => _weatherModel;
  void setWeather(String weatherModel) {
    _weatherModel = weatherModelFromJson(weatherModel);
    notifyListeners();
  }

  void setWeatherFromModel(WeatherModel weatherModel) {
    _weatherModel = weatherModel;
    notifyListeners();
  }
}
