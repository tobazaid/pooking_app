import 'package:flutter/material.dart';

class TextFFMobile extends StatelessWidget {
  final TextEditingController? controller; // خليها اختيارية (بدون required)
  const TextFFMobile({super.key, this.controller}); // شيل required

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: "ادخل رقم المحمول",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}