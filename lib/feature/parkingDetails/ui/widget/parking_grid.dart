import 'package:flutter/material.dart';

class ParkingGrid extends StatelessWidget {
  const ParkingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final isAvailable = index < 4; // أول 4 مربعات خضراء
        return Container(
          decoration: BoxDecoration(
            color: isAvailable ? const Color(0xFFA3E635) : const Color(0xFF2A2F45),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }
}