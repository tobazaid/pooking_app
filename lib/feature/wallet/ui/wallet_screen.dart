
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  int? selectedPayment;

  void selectPayment(int index) {
    setState(() {
      selectedPayment = index;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "تم اختيار طريقة الدفع رقم ${index + 1}",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("المحفظة"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Image.asset(
            "assets/image/١٢ · المحفظة-selection.png",
          ),

          const SizedBox(height: 20),

          const Text(
            "طرق الدفع",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          paymentItem(
            image: "assets/image/١٢ · المحفظة-selection (1).png",
            index: 0,
          ),

          const SizedBox(height: 20),

          paymentItem(
            image: "assets/image/١٢ · المحفظة-selection (2).png",
            index: 1,
          ),
        ],
      ),
    );
  }

  Widget paymentItem({
    required String image,
    required int index,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),

      onTap: () {
        selectPayment(index);
      },

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selectedPayment == index
                ? Colors.blue
                : Colors.transparent,
            width: 2,
          ),
        ),

        child: Image.asset(
          image,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
