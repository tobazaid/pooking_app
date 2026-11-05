import 'package:flutter/material.dart';

class CustemBotoom extends StatelessWidget {
  final String text; 
  final VoidCallback onTap; 
  
  // 1. متغيرات اختيارية للون الخلفية ولون النص
  final Color? backgroundColor; 
  final Color? textColor;

  const CustemBotoom({
    super.key,
    required this.text, 
    required this.onTap, 
    this.backgroundColor, // اختياري (لو مكتبتهوش هيبقى أبيض)
    this.textColor,       // اختياري (لو مكتبتهوش هيبقى أسود)
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
          // 2. لو المستخدم باعت لون هياخده، لو مبعتش هياخد الأبيض كافتراضي
          color: backgroundColor ?? Colors.white, 
        ),
        child: Center(
          child: Text(
            text, 
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              // 3. نفس الفكرة للون النص
              color: textColor ?? Colors.black, 
            ),
          ),
        ),
      ),
    );
  }
}