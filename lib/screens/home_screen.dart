import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weatherly/screens/city_screen.dart';
import 'package:weatherly/utils/constants.dart';
import 'package:weatherly/services/networking.dart';

Networking networking = Networking();

class HomeScreen extends StatefulWidget {
  var data;
  HomeScreen({super.key, required this.data});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map data;
  late int id;
  late String name;
  late num seaLevel;
  late num groundLevel;
  late num windSpeed;
  late num humidity;
  late num temp;
  late num minTemp;
  late num maxTemp;
  late num feelsLike;
  late var networkIcon;
  late String description;
  late String country;
  late double lat;
  late double long;

  @override
  void initState() {
    super.initState();
    updateUi(widget.data);
  }

  void updateUi(Map weatherData) {
    setState(() {
      lat = weatherData['coord']['lat'];
      long = weatherData['coord']['lon'];
      groundLevel = weatherData['main']['grnd_level'];
      name = weatherData['name'];
      country = weatherData['sys']['country'];
      id = weatherData['weather'][0]['id'];
      networkIcon = weatherData['weather'][0]['icon'];
      description = weatherData['weather'][0]['description'];
      seaLevel = weatherData['main']['sea_level'];
      windSpeed = weatherData['wind']['speed'];
      humidity = weatherData['main']['humidity'];
      temp = weatherData['main']['temp'];
      maxTemp = weatherData['main']['temp_max'];
      minTemp = weatherData['main']['temp_min'];
      feelsLike = weatherData['main']['feels_like'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () async {
              try {
                Map data = await networking.getLocationWeather();
                updateUi(data);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  '$e',
                  style: kErrorTextStyle,
                )));
              }
            },
            icon: const Icon(
              Icons.location_on,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  try {
                    FocusScope.of(context).unfocus();
                    String? cityName = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CityScreen()));
                    if (cityName != null) {
                      Map data = await networking.getCityWeather(cityName);
                      updateUi(data);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      '$e',
                      style: kErrorTextStyle,
                    )));
                  }
                },
                icon: const Icon(
                  Icons.location_city,
                  color: Colors.black87,
                  size: 30,
                ))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ///image
            Flexible(
              flex: 1,
              child: SizedBox(
                child: Center(
                  child: Image(
                    image: networking.getNetworkImage(networkIcon),
                  ),
                ),
              ),
            ),

            ///details
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///descripiton
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                          child: Text(
                        'Weather: $description',
                        style: kDetailTextStyle,
                      )),
                    ),
                  ),

                  ///temprature and all
                  Flexible(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(10.0)),
                              margin:
                                  const EdgeInsets.only(left: 10.0, right: 5.0),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'City name: $name',
                                    style: kDetailTextStyle,
                                  ),
                                  Text(
                                    'Country code: $country',
                                    style: kDetailTextStyle,
                                  ),
                                  Text(
                                    'Humidity: $humidity %',
                                    style: kDetailTextStyle,
                                  ),
                                  Text(
                                    'Wind Speed: $windSpeed m/s',
                                    style: kDetailTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 5.0,
                                right: 10.0,
                              ),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Temprature: $temp ℃',
                                    style: kDetailTextStyle,
                                  ),
                                  Text(
                                    'Feels Like: $feelsLike ℃',
                                    style: kDetailTextStyle,
                                  ),
                                  Text(
                                    'Min Temp: $minTemp ℃',
                                    style: kDetailTextStyle,
                                  ),
                                  Text(
                                    'Max Temp: $maxTemp ℃',
                                    style: kDetailTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),

                  ///other details
                  Flexible(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Latitide: $lat',
                                    style: kDetailTextStyle,
                                  ),
                                  Text(
                                    'Sea level: $seaLevel m',
                                    style: kDetailTextStyle,
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Longitude: $long',
                                    style: kDetailTextStyle,
                                  ),
                                  Text(
                                    'Ground level: $groundLevel m',
                                    style: kDetailTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
