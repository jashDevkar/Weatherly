import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherly/services/get_location.dart';
import 'package:weatherly/services/weather.dart';


/*

this file is responsible for managing data recieved from weather file

this file will request weather data based on location or based on city name

*/


class Networking{
  late double latitude;
  late double longitude;

  Future getLocationWeather()async{
    try{
      Position position = await getLocation();
      longitude = position.longitude;
      latitude = position.latitude;
      Weather weather = Weather(url: '${dotenv.env['FRONT_URL']}?lat=$latitude&lon=$longitude&appid=${dotenv.env['API_KEY']}&units=metric');
      var data =await  weather.requestData();
      return data;
    }
    catch(e){
      return Future.error(e);
    }
  }

  Future<Map> getCityWeather(String cityName)async{
    try{
      Weather weather = Weather(url: '${dotenv.env['FRONT_URL']}?q=$cityName&appid=${dotenv.env['API_KEY']}&units=metric');
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