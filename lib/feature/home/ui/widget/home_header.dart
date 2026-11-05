import 'package:flutter/material.dart';
import 'package:mhj_maps/mhj_maps.dart'; // استيراد مكتبة الخريطة

class HomeHeader extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const HomeHeader({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. الخريطة الحقيقية (بدل الخلفية الرمادية)
        // ملاحظة: الخريطة تحتاج مساحة محددة، والـ Stack يوفر ذلك
        SizedBox(
          height: 350, // نفس الارتفاع السابق
          width: double.infinity,
          child: MhjMapsMap(
            // إحداثيات القاهرة كمثال (يمكنك تغييرها لأي مدينة)
            center: const MhjMapsLatLng(lat: 30.0444, lng: 31.2357),
            zoom: 12,
            // اختيار ثيم فاتح يناسب التصميم
            theme: MhjMapsMapThemes.standard, 
            // إخفاء أزرار التكبير/التصغير الافتراضية لتجنب ازدحام الشاشة
            showZoomControls: false, 
          ),
        ),
        
        // 2. شريط البحث (يبقى فوق الخريطة)
        Positioned(
          top: 50,
          left: 20,
          right: 20,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              textDirection: TextDirection.rtl,
              decoration: const InputDecoration(
                hintText: "ابحث عن موقف قريب منك",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}