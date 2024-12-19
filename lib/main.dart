import 'package:flutter/material.dart';
import 'package:weatherly/screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitialScreen(),
    );
  }
}




// const String apiKey = 'f7d81d02538427786afe569f7b95cc6b';
// const String fronturl = 'https://api.openweathermap.org/data/2.5/weather';