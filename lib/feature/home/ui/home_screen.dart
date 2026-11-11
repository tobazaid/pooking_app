import 'package:flutter/material.dart';
import 'package:pooking_app/feature/home/ui/widget/home_header.dart';
import 'package:pooking_app/feature/home/ui/widget/parking_list_sheet.dart';
import 'package:pooking_app/feature/profile/ui/my_profile.dart'; // <--- ضيف ده

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _allParkings = [
    {
      'title': "جراج سيتي ستار",
      'distance': "2 كم - مغطى - 24 ساعة",
      'price': "20 ج.م / ساعة",
      'status': "12 مكان متاح",
      'statusColor': Colors.green,
      'iconColor': const Color(0xFF1A1F36),
      'tags': ['مغطى', '24 ساعة']
    },
    {
      'title': "موقف شارع الجمهورية",
      'distance': "3 كم - مكشوف - 24 ساعة",
      'price': "10 ج.م / ساعة",
      'status': "3 أماكن فقط",
      'statusColor': Colors.orange,
      'iconColor': const Color(0xFFE5E5E5),
      'tags': ['24 ساعة']
    },
    {
      'title': "موقف شحن سريع",
      'distance': "5 كم - مكشوف - شحن",
      'price': "15 ج.م / ساعة",
      'status': "8 أماكن متاحة",
      'statusColor': Colors.green,
      'iconColor': const Color(0xFF1A1F36),
      'tags': ['شحن كهربائي']
    },
  ];

  List<Map<String, dynamic>> _filteredParkings = [];
  String _selectedFilter = "الكل";
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _filteredParkings = _allParkings;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      _filteredParkings = _allParkings.where((parking) {
        final matchesSearch = parking['title'].toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesFilter = _selectedFilter == "الكل" || parking['tags'].contains(_selectedFilter);
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      // 1. الصفحة الرئيسية
      Stack(
        children: [
          HomeHeader(
            searchController: _searchController,
            onSearchChanged: (value) {
              _searchQuery = value;
              _applyFilters();
            },
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.90,
            builder: (context, scrollController) {
              return ParkingListSheet(
                parkings: _filteredParkings,
                selectedFilter: _selectedFilter,
                onFilterChanged: (filter) {
                  _selectedFilter = filter;
                  _applyFilters();
                },
              );
            },
          ),
        ],
      ),
      
      // 2. صفحة الحجوزات
      const Center(child: Text("هنا سجل حجوزاتي")),
      
      // 3. صفحة المحفظة
      const Center(child: Text("هنا محفظتي")),
      
      // 4. صفحة الحساب (MyProfile)
      const MyProfile(), // <--- غيرناها هنا
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF1A1F36),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), label: "استكشاف"),
            BottomNavigationBarItem(icon: Icon(Icons.directions_car_outlined), label: "حجوزاتي"),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: "المحفظة"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "حسابي"),
          ],
        ),
      ),
    );
  }
}