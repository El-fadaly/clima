import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.weatherData);

  final dynamic weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temp;
  String icon, message, cityName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUi(widget.weatherData);
  }

  void updateUi(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        icon = '';
        message = 'cant find ';
        cityName = '';

        return;
      }

      num tempo = weatherData['main']['temp'];
      temp = tempo.round();
      icon = weatherModel.getWeatherIcon(weatherData['weather'][0]['id']);
      message = weatherModel.getMessage(temp);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      EasyLoading.show();

                      var weatherData =
                          await weatherModel.getLocationWeatherData();
                      updateUi(weatherData);
                      EasyLoading.dismiss();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );
                      if (cityName != null) {
                        print('$cityName from location screen');
                        var cityWeather =
                            await weatherModel.getCityWeatherData(cityName);
                        updateUi(cityWeather);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      icon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
