import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/weather.dart';
import '../services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  void getLocation() async {
    var weatherData = await WeatherModel().getLocationWeatherData();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(weatherData),
        ));
  }

  @override
  Widget build(BuildContext context) {
    getLocation();

    return Scaffold(
      body: Center(
        child: SpinKitWave(
          size: 50.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
