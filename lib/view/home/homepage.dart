import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants/color_constants.dart';

import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/location_services.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/view/home/widgets/detail_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _locationController = TextEditingController();
  LocationServices locationServices = LocationServices();
  WeatherServices weatherServices = WeatherServices();
  String cityName = '';
  @override
  void initState() {
    // TODO: implement initState

    getLocData();
    getWeather();

    super.initState();
  }

  getLocData() async {
    await locationServices.getLocation(context: context);
  }

  getWeather() async {
    await weatherServices.getWeatherDetail(context: context);
  }

  @override
  Widget build(BuildContext context) {
    var weatherProvider = Provider.of<WeatherProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
              color: primColor,
              onPressed: () => Navigator.popAndPushNamed(context, '/'),
              icon: Icon(
                Icons.help,
                size: 30,
              ))
        ],
      ),
      backgroundColor: primWhite,
      floatingActionButton: IconButton(
        style: IconButton.styleFrom(
            backgroundColor: labelGrn, foregroundColor: primColor),
        onPressed: () async {
          log('Acquiring location');
          await locationServices.getLocation(context: context);
          log('Acquired location');
        },
        icon: const Icon(Icons.location_on_outlined),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: TextFormField(
                onFieldSubmitted: (value) async {
                  log('Search Pressed');
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.clear();
                  preferences.setString('city', _locationController.text);
                  setState(() {
                    cityName = preferences.getString('city').toString();
                  });
                  await getWeather();
                },
                textAlign: TextAlign.left,
                controller: _locationController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () async {
                        log('Search Pressed');
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.clear();
                        preferences.setString('city', _locationController.text);
                        setState(() {
                          cityName = preferences.getString('city').toString();
                        });
                        await getWeather();
                      },
                      icon: const Icon(Icons.search)),
                  contentPadding: const EdgeInsets.only(
                      left: 30, top: 10, bottom: 10, right: 20),
                  fillColor: labelBlue,
                  filled: true,
                  hintText: weatherProvider.weatherModel.location!.name,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                    color: labelRed, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on),
                    Text(weatherProvider.weatherModel.location!.name == ''
                        ? 'Getting Location'
                        : weatherProvider.weatherModel.location!.name)
                  ],
                ),
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Positioned(
                      child: Text(
                        '30',
                        style: TextStyle(fontSize: 120),
                      ),
                    ),
                    const Positioned(
                        right: -10,
                        top: 40,
                        child: Text(
                          '\u2109',
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              decoration: BoxDecoration(
                  color: labelGrn, borderRadius: BorderRadius.circular(50)),
              child: const Text(
                'Cloudy',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: primColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailWidget(
                    title: 'Wind',
                    values: weatherProvider.weatherModel.current?.windMph !=
                            null
                        ? '${weatherProvider.weatherModel.current?.windMph.toString()}MPH'
                        : '  MPH',
                  ),
                  DetailWidget(
                    title: 'Wind Direction',
                    values: weatherProvider.weatherModel.current?.windDir !=
                            null
                        ? '${weatherProvider.weatherModel.current?.windMph.toString()}'
                        : '  ...',
                  ),
                  DetailWidget(
                    title: 'Pressure',
                    values: weatherProvider.weatherModel.current?.pressureMb !=
                            null
                        ? '${weatherProvider.weatherModel.current?.pressureMb.toString()}'
                        : '  milibar',
                  ),
                  DetailWidget(
                    title: 'Precipitation',
                    values: weatherProvider.weatherModel.current?.precipMm !=
                            null
                        ? '${weatherProvider.weatherModel.current?.precipMm.toString()}'
                        : ' mm',
                  ),
                  DetailWidget(
                    title: 'Humidity',
                    values: weatherProvider.weatherModel.current?.humidity !=
                            null
                        ? '${weatherProvider.weatherModel.current?.humidity.toString()}'
                        : ' ',
                  ),
                  DetailWidget(
                    title: 'Feels Like',
                    values: weatherProvider.weatherModel.current?.tempF != null
                        ? '${weatherProvider.weatherModel.current!.tempF.toString()}\u2109'
                        : ' \u2109',
                  ),
                  DetailWidget(
                    title: 'UV',
                    values: weatherProvider.weatherModel.current!.uv != null
                        ? '${weatherProvider.weatherModel.current?.uv.toString()}'
                        : ' ',
                  ),
                  DetailWidget(
                    title: 'Last Updated',
                    values: weatherProvider.weatherModel.current!.lastUpdated !=
                            null
                        ? '${weatherProvider.weatherModel.current?.lastUpdated.toString()}'
                        : ' ',
                  ),
                  const SizedBox(
                    height: 90,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
