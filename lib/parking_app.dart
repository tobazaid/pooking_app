import 'package:flutter/material.dart';
import 'package:pooking_app/feature/auth/login/ui/login_screen.dart';
import 'package:pooking_app/feature/auth/regiter/ui/register_screen.dart';
import 'package:pooking_app/feature/home/ui/home_screen.dart';
import 'package:pooking_app/feature/onbording/ui/onBording_screen_1.dart';
import 'package:pooking_app/feature/onbording/ui/onBording_screen_2.dart';
import 'package:pooking_app/feature/onbording/ui/onBording_screen_3.dart';
import 'package:pooking_app/feature/parkingDetails/ui/Booking%20confirmation/ui/booking_confirmation.dart';
import 'package:pooking_app/feature/parkingDetails/ui/parking_details_screen.dart';

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
        OnbordingScreen3.routeName:(context) => OnbordingScreen3(),
        LoginScreen.routeName:(context) => LoginScreen(),
        RegisterScreen.routeName:(context) => RegisterScreen(),
        HomeScreen.routeName:(context) => HomeScreen(),
        ParkingDetailsScreen.routeName:(context) => ParkingDetailsScreen(),
        BookingConfirmation.routeName:(context) => BookingConfirmation()
      },
    );
  }
}