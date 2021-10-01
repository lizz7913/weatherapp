import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';




class CurrentWeatherPage extends StatefulWidget {
  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot){
            if (snapshot.hasData){
              Weather _weather =snapshot.data;
              if (_weather==null) {

                return Text("Error getting weather");

              } else {
                return weatherBox(_weather);
              }
            } else {
              return CircularProgressIndicator();
            }
          },
          future: getCurrentWeather(),
        ),
      ),
    );
  }
  Widget weatherBox(Weather _weather) {
    return Column(
        children: <Widget>[
          Text("${_weather.temp}"),
          Text("${_weather.description}"),
          Text("Feels:${_weather.feelsLike}"),
          Text("H:${_weather.high} L:${_weather.low}"),
        ]
    );
  }
  Future getCurrentWeather() async {
    Weather weather;
    String city = "London,uk";
    String apiKey = "25e732448424f81ea879a72bbb737be1";
    var url = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    try {
    final response = await http.get(Uri.parse(url));
    print("hello");
    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    } else {

    }
  } catch(e){print("exception occured");
  print(e.toString());
    }
    return weather;
  }

}
