import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/constants/color_constants.dart';
import 'package:weather_app/view/home/widgets/detail_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
      ),
      backgroundColor: primWhite,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: TextFormField(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 30, top: 10, bottom: 10, right: 20),
                  fillColor: labelBlue,
                  filled: true,
                  hintText: 'Search city or location',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      child: Text(
                        '30',
                        style: TextStyle(fontSize: 120),
                      ),
                    ),
                    Positioned(
                        right: -10,
                        top: 40,
                        child: Text(
                          '\u2109',
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                )),
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              decoration: BoxDecoration(
                  color: labelGrn, borderRadius: BorderRadius.circular(50)),
              child: Text(
                'Cloudy',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: primColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailWidget(
                    title: 'Wind',
                    values: '30MPH',
                  ),
                  DetailWidget(
                    title: 'Wind Direction',
                    values: 'SSW',
                  ),
                  DetailWidget(
                    title: 'Pressure',
                    values: '10.3 Inch',
                  ),
                  DetailWidget(
                    title: 'Precipitation',
                    values: '0.3',
                  ),
                  DetailWidget(title: 'Humidity', values: '72'),
                  DetailWidget(title: 'Feels Like', values: '30 \u2109'),
                  DetailWidget(title: 'UV', values: '3'),
                  SizedBox(
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
