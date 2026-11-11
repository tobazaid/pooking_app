
import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_text_style.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: () {},

        icon: const Icon(
          Icons.logout,
          color: Colors.red,
        ),

        label: const Text(
          "تسجيل الخروج",
          style: AppTextStyle.profileLogout,
        ),

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade50,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
