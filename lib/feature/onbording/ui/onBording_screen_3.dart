import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_color.dart';
import 'package:pooking_app/core/classes/app_text_style.dart';
import 'package:pooking_app/core/custems/custem_botoom.dart';
import 'package:pooking_app/feature/auth/login/ui/login_screen.dart';

class OnbordingScreen3 extends StatelessWidget {
  static const String routeName = "onBording_Screen3";
  const OnbordingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Column(
        children: [
          SizedBox(height: 200),
          Image.asset("assets/image/٩ · ترحيب ٣-selection.png"),
          SizedBox(height: 20),
          Text("ادفع وادخل بالرمز", style: AppTextStyle.heading),
          SizedBox(height: 120),
          CustemBotoom(
            text: "ابدأ الان",
            onTap: () {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
