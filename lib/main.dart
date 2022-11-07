import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/loc_provider.dart';
import 'package:weather_app/providers/location_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/view/home/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => LocationProvider(),
      ),
      ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ChangeNotifierProvider(create: (context) => LocProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      routes: {'/': (context) => const HomePage()},
    );
  }
}
