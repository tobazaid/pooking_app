import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_color.dart';
import 'package:pooking_app/core/classes/app_text_style.dart';
import 'package:pooking_app/core/custems/custem_botoom.dart';
import 'package:pooking_app/feature/onbording/ui/onBording_screen_3.dart';

class OnbordingScreen2 extends StatelessWidget {
  static const String routeName = "onBording_screen_2";
  const OnbordingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Column(children: [
          SizedBox(height: 200),
          Image.asset("assets/image/٨ · ترحيب ٢-selection.png"),
          SizedBox(height: 20),
          Text("احجز مكانك قبل ما توصل", style: AppTextStyle.heading),
          SizedBox(height: 120),
          CustemBotoom(
            text: "التالي",
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                OnbordingScreen3.routeName,
              );
            },
          ),
      ],),
    );
  }
}
