import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_text_style.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("تسجيل الخروج", textAlign: TextAlign.center),

          content: const Text(
            "هل أنت متأكد من تسجيل الخروج؟",
            textAlign: TextAlign.center,
          ),

          actionsAlignment: MainAxisAlignment.spaceEvenly,

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "لا",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'login_screen',
                  (route) => false,
                );
              },
              child: const Text(
                "نعم",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: () {
          showLogoutDialog(context);
        },

        icon: const Icon(Icons.logout, color: Colors.red),

        label: const Text("تسجيل الخروج", style: AppTextStyle.profileLogout),

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
