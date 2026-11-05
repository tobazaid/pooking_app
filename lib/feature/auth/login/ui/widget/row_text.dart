
import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_color.dart';
import 'package:pooking_app/feature/auth/regiter/ui/register_screen.dart';

class RowText extends StatelessWidget {
  const RowText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "معندكش حساب؟",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),

        const SizedBox(width: 5),

        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              RegisterScreen.routeName,
            );
          },
          child: Text(
            "إنشاء حساب جديد",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColor.mainColor,
            ),
          ),
        ),
      ],
    );
  }
}
