import 'package:flutter/material.dart';

class BookingWidgets {
  // 1. كارت السيارة
  static Widget buildCarCard({
    required String carName,
    required String carNumber,
    required VoidCallback onChange,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.time_to_leave, color: Colors.black, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(carName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(carNumber, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
          TextButton(
            onPressed: onChange,
            child: const Text("تغيير", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  // 2. كارت الوقت
  static Widget buildTimeCard({
    required String date,
    required String startTime,
    required String endTime,
    required int durationHours,
    required VoidCallback onIncrease,
    required VoidCallback onDecrease,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("الوقت", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(date),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              buildTimeBox("من", startTime),
              const SizedBox(width: 10),
              buildTimeBox("إلى", endTime),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("المدة", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  buildCounterButton(Icons.add, onIncrease),
                  const SizedBox(width: 15),
                  Text("$durationHours ساعات", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(width: 15),
                  buildCounterButton(Icons.remove, onDecrease),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 3. كارت اختيار المكان
  static Widget buildSpotCard({
    required List<String> spots,
    required String selectedSpot,
    required Function(String) onSelect,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("اختر المكان", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("الدور الأول", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: spots.map((spot) => buildSpotBox(spot, selectedSpot == spot, onSelect)).toList(),
          ),
        ],
      ),
    );
  }

  // 4. كارت الدفع
  static Widget buildPaymentCard({
    required String paymentMethod,
    required VoidCallback onChange,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              paymentMethod.contains("نقداً") ? Icons.money : Icons.credit_card,
              color: Colors.black,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(paymentMethod, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                const Text("طريقة الدفع", style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
          TextButton(
            onPressed: onChange,
            child: const Text("تغيير", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  // 5. ملخص الحساب
  static Widget buildSummaryCard({
    required int parkingPrice,
    required int serviceFee,
    required int totalPrice,
    required int durationHours,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$durationHours ساعات × ٢٥ ج.م", style: const TextStyle(fontSize: 14, color: Colors.grey)),
              Text("$parkingPrice ج.م"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("رسوم الخدمة", style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text("$serviceFee ج.م"),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("الإجمالي", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("$totalPrice ج.م", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  // --- عناصر مساعدة ---
  static BoxDecoration cardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
    );
  }

  static Widget buildTimeBox(String label, String time) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey.shade100),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 5),
            Text(time, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  static Widget buildCounterButton(IconData icon, VoidCallback onPressed) {
    final isAdd = icon == Icons.add;
    return Container(
      decoration: BoxDecoration(
        color: isAdd ? const Color(0xFF1A1F36) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: isAdd ? Colors.white : Colors.black, size: 20),
      ),
    );
  }

  static Widget buildSpotBox(String label, bool isSelected, Function(String) onSelect) {
    return InkWell(
      onTap: () => onSelect(label),
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFA3E635) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? const Color(0xFFA3E635) : Colors.transparent),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}