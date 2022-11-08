import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/constants/color_constants.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5),
        () => Navigator.popAndPushNamed(context, '/home'));
    Stopwatch().toString();

    return Scaffold(
      backgroundColor: primColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(80),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/border.png',
                      ),
                      fit: BoxFit.fill)),
              child: Center(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Text(
                      'We show weather for you',
                      style: TextStyle(
                          color: primWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: labelGrn),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/home');
                      },
                      child: const Text('Skip')),
                  TweenAnimationBuilder<Duration>(
                      duration: const Duration(seconds: 5),
                      tween: Tween(
                          begin: const Duration(seconds: 5),
                          end: Duration(seconds: 1)),
                      onEnd: () {},
                      builder: (BuildContext context, Duration value,
                          Widget? child) {
                        final seconds = value.inSeconds % 60;
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text('Skipping in $seconds seconds',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: primWhite,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20)));
                      }),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
