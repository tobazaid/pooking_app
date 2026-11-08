import 'package:flutter/material.dart';

class ParkingHeader extends StatelessWidget {
  const ParkingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // زر القلب (شمال)
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          child: const Icon(Icons.favorite_border, color: Colors.black),
        ),
        // زر الرجوع (يمين)
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}