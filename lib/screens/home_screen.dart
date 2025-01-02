import 'package:flutter/material.dart';
import 'package:weatherly/components/main_data.dart';
import 'package:weatherly/components/other_data.dart';
import 'package:weatherly/screens/city_screen.dart';
import 'package:weatherly/utils/constants.dart';
import 'package:weatherly/services/networking.dart';


/*


this screen will display all weather data

if any error occured it will show error in snack bar


this screen will have an option of location and city

 */

Networking networking = Networking();

class HomeScreen extends StatefulWidget {
  final Map data;
  HomeScreen({super.key, required this.data});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map data;
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

    ///this will help to update ui as per location 
    setState(() {
      lat = weatherData['coord']['lat'];
      long = weatherData['coord']['lon'];
      groundLevel = weatherData['main']['grnd_level'];
      name = weatherData['name'];
      country = weatherData['sys']['country'];
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
    Map<String, dynamic> myTempDataMap = {
      'temp': '$temp ℃',
      'feels like': '$feelsLike ℃',
      'max temp': '$maxTemp ℃',
      'min temp': '$minTemp ℃'
    };

    Map<String, dynamic> myMainData = {
      'Country code': '$country',
      'City': '$name',
      'Wind': '$windSpeed m/s',
      'Humidity': '$humidity %'
    };

    Map<String, dynamic> otherData1 = {
      'Latitude': lat,
      'Sea level': '$seaLevel m'
    };
    Map<String, dynamic> otherData2 = {
      'Longitude': lat,
      'Ground level': '$groundLevel m'
    };

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          ///by presson on this icon 
          ///weather of current location can be seen on the screen
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

          ///by pressing on city icon
          ///weather of that city can be seen
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
            ///this widget will display icon related to weather
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
            ///this widgets will display all details of  weather
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///descripiton
                  ///this widget will show description of weather data
                  Expanded(
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
                        ),
                      ),
                    ),
                  ),

                  ///temprature and all
                  ///this widget will display all main details of weather data
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        MainData(myDataMap: myMainData),
                        MainData(myDataMap: myTempDataMap),
                      ],
                    ),
                  ),

                  ///other details
                  ///this widget will display all other details regarding weather
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        bottom: 10.0,
                        top: 10.0,
                      ),
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OtherData(myOtherData: otherData1),
                          OtherData(myOtherData: otherData2)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
