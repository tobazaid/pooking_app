import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_text_style.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // زر الرجوع
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        const SizedBox(height: 30),
        // العناوين
        Text("إنشاء حساب جديد", style: AppTextStyle.extrabold.copyWith(fontSize: 28, color: Colors.black)),
        const SizedBox(height: 10),
        Text("ثواني وتبقى جاهز تحجز أول موقف", style: AppTextStyle.regular.copyWith(fontSize: 16, color: Colors.grey.shade600)),
      ],
    );
  }
}