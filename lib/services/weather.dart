import 'dart:convert';

import '../utilities/constants.dart';
import 'location.dart';
import 'networking.dart';

class WeatherModel {
  Future<dynamic> getLocationWeatherData() async {
    Location location = Location();
    await location.getLocation();
    print('long' + location.longitude.toString());
    print('lat' + location.latitude.toString());
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$APIKEY&units=metric');
    var data = await networkHelper.getData();

    print(jsonDecode(data));

    var weatherData = jsonDecode(data);
    return weatherData;
  }

  Future<dynamic> getCityWeatherData(String cityName) async {
    Location location = Location();
    await location.getLocation();
    print('long' + location.longitude.toString());
    print('lat' + location.latitude.toString());
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$APIKEY&units=metric');
    var data = await networkHelper.getData();

    print(jsonDecode(data));

    var weatherData = jsonDecode(data);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
