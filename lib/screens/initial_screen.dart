import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weatherly/utils/constants.dart';
import 'package:weatherly/screens/home_screen.dart';
import 'package:weatherly/services/networking.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  bool _error = false;
  late String _errorMessage;

  @override
  void initState(){
    super.initState();
    getLocationFromDevice();
  }

  void getLocationFromDevice()async{
    try{
      Networking networking =Networking();
      var data  = await networking.getLocationWeather();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen(data: data)));
      setState(() {
        _error = false;
      });
    }
    catch (error){
      _errorMessage = error.toString();
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors:[
                  Colors.deepPurpleAccent,
                  Colors.black87
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Fetching Location...',style: kLoaderScreenText,),
                    const SizedBox(width: 15.0,),
                    LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 30)
                  ]
                ),
                const SizedBox(height: 10.0,),
                if(_error)
                    Text('Error: $_errorMessage',style: kErrorTextStyle,),
                const SizedBox(height: 10.0,),
                if(_error)
                  ElevatedButton(onPressed: getLocationFromDevice,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        )
                      ), child: const Text('Retry')),
      
              ],
            ),
          ),
        ),
      ),
    );
  }
}
