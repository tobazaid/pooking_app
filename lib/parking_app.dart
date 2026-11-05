import 'package:flutter/material.dart';
import 'package:pooking_app/feature/onbording/ui/onBording_screen_1.dart';
import 'package:pooking_app/feature/onbording/ui/onBording_screen_2.dart';
import 'package:pooking_app/feature/onbording/ui/onBording_screen_3.dart';

class ParkingApp extends StatelessWidget {
  const ParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: OnbordingScreen1.routeName,
      routes: {
        OnbordingScreen1.routeName:(context) => OnbordingScreen1(),
        OnbordingScreen2.routeName:(context) => OnbordingScreen2(),
        OnbordingScreen3.routeName:(context) => OnbordingScreen3()
      },
    );
  }
}