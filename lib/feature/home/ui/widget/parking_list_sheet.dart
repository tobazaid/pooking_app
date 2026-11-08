import 'package:flutter/material.dart';
import 'package:pooking_app/feature/parkingDetails/ui/parking_details_screen.dart'; // ضيف المسار الصح

class ParkingListSheet extends StatefulWidget {
  final List<Map<String, dynamic>> parkings;
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const ParkingListSheet({
    super.key,
    required this.parkings,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  State<ParkingListSheet> createState() => _ParkingListSheetState();
}

class _ParkingListSheetState extends State<ParkingListSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 15),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                const Text("مواقف قريبة منك", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("${widget.parkings.length} متاحة الآن", style: const TextStyle(fontSize: 14, color: Colors.green)),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // أزرار الفلترة
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                _buildFilterChip("الكل", widget.selectedFilter == "الكل"),
                _buildFilterChip("مغطى", widget.selectedFilter == "مغطى"),
                _buildFilterChip("24 ساعة", widget.selectedFilter == "24 ساعة"),
                _buildFilterChip("شحن كهربائي", widget.selectedFilter == "شحن كهربائي"),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // قائمة المواقف
          Expanded(
            child: widget.parkings.isEmpty
                ? const Center(child: Text("لا توجد مواقف مطابقة للبحث"))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: widget.parkings.length,
                    itemBuilder: (context, index) {
                      final parking = widget.parkings[index];
                      return _buildParkingCard(
                        title: parking['title'],
                        distance: parking['distance'],
                        price: parking['price'],
                        status: parking['status'],
                        statusColor: parking['statusColor'],
                        iconColor: parking['iconColor'],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String title, bool isSelected) {
    return GestureDetector(
      onTap: () => widget.onFilterChanged(title),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1F36) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildParkingCard({
    required String title,
    required String distance,
    required String price,
    required String status,
    required Color statusColor,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: () {
        // الانتقال لشاشة تفاصيل الموقف
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParkingDetailsScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(distance, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                const SizedBox(height: 10),
                Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(status, style: TextStyle(fontSize: 12, color: statusColor, fontWeight: FontWeight.w600)),
              ],
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  "P",
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}