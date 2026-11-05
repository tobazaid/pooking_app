import 'package:flutter/material.dart';

class CustemBotoom extends StatelessWidget {
  final String text; // متغير عشان تكتب اللي انت عايزه
  final VoidCallback onTap; // عشان تحدد لما تدوس عليه يعمل ايه

  const CustemBotoom({
    super.key,
    required this.text, // مطلوب تكتب النص
    required this.onTap, // مطلوب تحدد الوظيفة
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            text, // هنا بنستخدم المتغير
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}