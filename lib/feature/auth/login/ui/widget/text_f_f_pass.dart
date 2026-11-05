import 'package:flutter/material.dart';

class TextFFPass extends StatefulWidget {
  const TextFFPass({super.key});

  @override
  State<TextFFPass> createState() => _TextFFPassState();
}

class _TextFFPassState extends State<TextFFPass> {
  // 1. متغير لحفظ حالة إظهار/إخفاء الباسورد
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // 2. ربط الحالة بالـ obscureText
      obscureText: !_isPasswordVisible, 
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        // 3. تغيير الأيقونة والوظيفة بناءً على الحالة
        prefixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible 
              ? Icons.visibility // لو ظاهر
              : Icons.visibility_off, // لو مخفي
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible; // عكس الحالة
            });
          },
        ),
        hintText: "ادخل كلمة المرور",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}