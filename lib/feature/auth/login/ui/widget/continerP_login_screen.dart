import 'package:flutter/material.dart';

class ContinerpLoginScreen extends StatelessWidget {
  const ContinerpLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          Alignment.centerRight, // جرب centerLeft لو عايزها الناحية التانية
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: const Center(
          child: Text(
            "P",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
