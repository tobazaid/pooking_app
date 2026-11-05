import 'package:flutter/material.dart';
import 'package:pooking_app/feature/onbording/ui/onBording_screen_1.dart';

class ParkingApp extends StatelessWidget {
  const ParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnbordingScreen1(),
    );
  }
}