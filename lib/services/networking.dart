import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherly/services/getLocation.dart';
import 'package:weatherly/services/weather.dart';

const String apiKey = 'f7d81d02538427786afe569f7b95cc6b';
const String fronturl = 'https://api.openweathermap.org/data/2.5/weather';




class Networking{
  late double latitude;
  late double longitude;

  Future getLocationWeather()async{
    try{
      Position position = await getLocation();
      longitude = position.longitude;
      latitude = position.latitude;
      Weather weather = Weather(url: '$fronturl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
      var data =await  weather.requestData();
      return data;
    }
    catch(e){
      return Future.error(e);
    }
  }

  Future<Map> getCityWeather(String cityName)async{
    try{
      Weather weather = Weather(url: '$fronturl?q=$cityName&appid=$apiKey&units=metric');
      var data = await weather.requestData();
      return data;
    }
    catch(e){
      return Future.error('$e');
    }
  }


  NetworkImage getNetworkImage(icon){
    return NetworkImage('https://openweathermap.org/img/wn/$icon@2x.png',scale: 0.7);
  }
}