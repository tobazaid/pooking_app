
import 'package:flutter/material.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "حجوزاتي",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Image.asset(
            "assets/image/١١ · حجوزاتي-selection.png",
            width: double.infinity,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 15),

          Image.asset(
            "assets/image/١١ · حجوزاتي-selection (1).png",
            width: double.infinity,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 15),

          Image.asset(
            "assets/image/١١ · حجوزاتي-selection (2).png",
            width: double.infinity,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 25),

          const Text(
            "آخر حجوزاتك",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 15),

          InkWell(
            borderRadius: BorderRadius.circular(18),

            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم الضغط على آخر حجز"),
                ),
              );
            },

            child: Image.asset(
              "assets/image/١١ · حجوزاتي-selection (3).png",
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
