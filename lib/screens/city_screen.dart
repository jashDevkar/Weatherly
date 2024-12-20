import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CityScreen extends StatelessWidget {
  CityScreen({super.key});

  TextEditingController cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/city2.jpg'),fit: BoxFit.cover,)
          ),
          constraints: const BoxConstraints.expand(),
          child:Container(
            margin: const EdgeInsets.only(top: 40.0),
            padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 TextField(
                   controller: cityNameController,
                   style: const TextStyle(color: Colors.white),
                   maxLength: 20,
                   decoration: InputDecoration(
                      labelText: 'Enter city name',
                      focusColor: Colors.white,
                      labelStyle: const TextStyle(color: Colors.white),
                      counterStyle: const TextStyle(color:Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      floatingLabelStyle: const TextStyle(color: Colors.white),
                    ),
                ),
                const SizedBox(height: 20.0,),
                ElevatedButton(onPressed: (){
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context,cityNameController.text);
                },
                    style:ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      )
                    ) ,
                    child: const Text('Submit',style: TextStyle(color: Colors.black87),))
              ],
            ),
          )
        ),
      ),
    );
  }
}
