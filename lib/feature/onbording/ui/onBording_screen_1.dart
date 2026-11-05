import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_text_style.dart';
import 'package:pooking_app/core/custems/custem_botoom.dart';
import 'package:pooking_app/feature/onbording/ui/onBording_screen_2.dart';

class OnbordingScreen1 extends StatelessWidget {
  static const String routeName = "onbording_screen1";
  const OnbordingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101828),
      body: Column(
        children: [
          SizedBox(height: 200),
          Image.asset("assets/image/٧ · ترحيب ١-selection.png"),
          SizedBox(height: 20),
          Text("مرحبا بك في التطبيق", style: AppTextStyle.heading),
          SizedBox(height: 120),
          CustemBotoom(
            text: "التالي",
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                OnbordingScreen2.routeName,
              );
            },
          ),
        ],
      ),
    );
  }
}
