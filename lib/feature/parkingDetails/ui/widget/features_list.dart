import 'package:flutter/material.dart';

class FeaturesList extends StatelessWidget {
  const FeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة المميزات
    final List<String> features = [
      "مغطى",
      "كاميرات مراقبة",
      "24 ساعة",
      "شحن كهربائي",
    ];

    return Wrap(
      spacing: 8, // المسافة الأفقية بين العناصر
      runSpacing: 8, // المسافة العمودية لو العناصر نزلت سطر جديد
      children: features.map((feature) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100, // لون خلفية فاتح
            borderRadius: BorderRadius.circular(20), // حواف دائرية
            border: Border.all(color: Colors.grey.shade300), // إطار خفيف
          ),
          child: Text(
            feature,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
        );
      }).toList(),
    );
  }
}