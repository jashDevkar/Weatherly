import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weatherly/constants.dart';
import 'package:weatherly/services/getLocation.dart';

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
      var position = await getLocation();
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
    return Scaffold(
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
              SizedBox(height: 10.0,),
              if(_error)
                  Text('Error: $_errorMessage',style: kErrorTextStyle,),
              if(_error)
                ElevatedButton(onPressed: getLocationFromDevice, child: Text('Ask again'))

            ],
          ),
        ),
      ),
    );
  }
}
