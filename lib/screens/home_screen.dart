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
  late int seaLevel;
  late num windSpeed;
  late int humidity;
  late double temp;
  late double minTemp;
  late double maxTemp;
  late double feelsLike;
  late var networkIcon;
  late String description;
  late String country;

  @override
  void initState(){
    super.initState();
    updateUi(widget.data);

  }

  void updateUi(Map weatherData){
    print(weatherData);
    setState(() {
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
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: ()async {
              try{
                Map data = await networking.getLocationWeather();
                updateUi(data);
              }
              catch(e){
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e',style: kErrorTextStyle,)));
              }
            },
            icon: const Icon(
              Icons.foggy,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  try{
                    FocusScope.of(context).unfocus();
                    String cityName = await Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen()));
                    Map data = await networking.getCityWeather(cityName);
                    updateUi(data);
                  }
                  catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e',style: kErrorTextStyle,)));
                  }

                },
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.black87,
                  size: 30,
                ))
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 9,
              child: Center(
                child:Container(
                  width: 200.0,
                  child: Image(image: networking.getImage(id),),
                )
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      margin: const EdgeInsets.only(bottom: 10.0,left: 10.0,right: 10.0),
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Weather :-  $description',style: kDetailTextStyle,),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Flexible(
              flex: 5,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      margin: const EdgeInsets.only(bottom: 30.0,left: 10.0),
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('City name :  $name',style: kDetailTextStyle,),
                          Text('Country code :  $country',style: kDetailTextStyle,),
                          Text('Humidity :  $humidity%',style: kDetailTextStyle,),
                          Text('Wind speed :  $windSpeed',style: kDetailTextStyle,),


                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      margin: const EdgeInsets.only(bottom: 30.0,right: 10.0),
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Temprature :  $temp',style: kDetailTextStyle,),
                          Text('Feels like :  $feelsLike',style: kDetailTextStyle,),
                          Text('Max temp :  $temp',style: kDetailTextStyle,),
                          Text('Min temp :  $minTemp',style: kDetailTextStyle,),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
