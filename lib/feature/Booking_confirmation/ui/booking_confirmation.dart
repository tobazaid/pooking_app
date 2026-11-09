import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:pooking_app/feature/Booking_confirmation/ui/widget/booking_widgets.dart';
import 'package:pooking_app/services/booking_model.dart'; // استدعاء البيانات
import 'package:pooking_app/services/booking_service.dart'; // خدمة الحجز

class BookingConfirmation extends StatefulWidget {
  static const String routeName = "Booking confirmation";
  const BookingConfirmation({super.key});

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  final BookingService _bookingService = BookingService();

  bool isLoading = false;
  int durationHours = 3;
  final int pricePerHour = 25;
  final int serviceFee = 5;

  late final DateTime startAt = _getNextFullHour();

  String selectedSpot = "A4";
  String selectedCar = "تويوتا كورولا";
  String carNumber = "ن ص ع ١٢٣٤";
  String selectedPayment = "بطاقة تنتهي بـ ٤٢١١";

  // الحسابات
  int get parkingPrice => durationHours * pricePerHour;
  int get totalPrice => parkingPrice + serviceFee;

  DateTime _getNextFullHour() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour + 1);
  }

  DateTime get endAt => startAt.add(Duration(hours: durationHours));

  // تحويل الأرقام للعربية
  String _toArabicNumbers(String value) {
    const english = '0123456789';
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    for (int i = 0; i < english.length; i++) {
      value = value.replaceAll(english[i], arabic[i]);
    }
    return value;
  }

  // تنسيق الوقت
  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour >= 12 ? 'م' : 'ص';
    return '${_toArabicNumbers(hour.toString().padLeft(2, '0'))}:٠٠ $period';
  }

  // تنسيق التاريخ
  String _formatDate(DateTime date) {
    const weekdays = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
    const months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    return '${weekdays[date.weekday - 1]} ${_toArabicNumbers(date.day.toString())} ${months[date.month - 1]}';
  }

  // زيادة ونقصان المدة
  void _increaseDuration() {
    setState(() {
      durationHours++;
    });
  }

  void _decreaseDuration() {
    if (durationHours > 1) {
      setState(() {
        durationHours--;
      });
    }
  }

  // تغيير السيارة
  void _changeCar() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("اختر السيارة", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              ...BookingData.cars.map((car) {
                final isSelected = selectedCar == car["name"];
                return ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: Text(car["name"]!),
                  subtitle: Text(car["number"]!),
                  trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
                  onTap: () {
                    setState(() {
                      selectedCar = car["name"]!;
                      carNumber = car["number"]!;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  // تغيير طريقة الدفع
  void _changePayment() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("اختر طريقة الدفع", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              ...BookingData.paymentMethods.map((method) {
                final isSelected = selectedPayment == method;
                return ListTile(
                  leading: Icon(method.contains("نقداً") ? Icons.money : Icons.credit_card),
                  title: Text(method),
                  trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
                  onTap: () {
                    setState(() {
                      selectedPayment = method;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  // اختيار الموقف
  void _selectSpot(String spot) {
    setState(() {
      selectedSpot = spot;
    });
  }

  // تأكيد الحجز
  Future<void> _confirmBooking() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      final bookingId = await _bookingService.createBooking(
        carName: selectedCar,
        carNumber: carNumber,
        parkingSpot: selectedSpot,
        startAt: startAt,
        durationHours: durationHours,
        parkingPrice: parkingPrice,
        serviceFee: serviceFee,
        totalPrice: totalPrice,
        paymentMethod: selectedPayment,
      );

      if (!mounted) return;
      setState(() => isLoading = false);
      _showSuccessDialog(bookingId);
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating),
      );
    }
  }

  // شاشة النجاح
  void _showSuccessDialog(String bookingId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 65),
              const SizedBox(height: 15),
              const Text("تم تسجيل الحجز بنجاح", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Text("رقم الحجز:\n$bookingId", textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              Text("المكان: $selectedSpot"),
              Text("السيارة: $selectedCar"),
              Text("الإجمالي: ${_toArabicNumbers(totalPrice.toString())} ج.م"),
              const SizedBox(height: 10),
              const Text("حالة الحجز: في انتظار التأكيد", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
              const Text("حالة الدفع: غير مدفوع", style: TextStyle(color: Colors.red)),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A1F36)),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.pop(context);
                },
                child: const Text("تم", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl, // الاتجاه من اليمين
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 15),

                // 1. كارت السيارة
                BookingWidgets.buildCarCard(
                  carName: selectedCar,
                  carNumber: carNumber,
                  onChange: _changeCar,
                ),
                const SizedBox(height: 20),

                // 2. كارت الوقت
                BookingWidgets.buildTimeCard(
                  date: _formatDate(startAt),
                  startTime: _formatTime(startAt),
                  endTime: _formatTime(endAt),
                  durationHours: durationHours,
                  onIncrease: _increaseDuration,
                  onDecrease: _decreaseDuration,
                ),
                const SizedBox(height: 20),

                // 3. كارت اختيار المكان
                BookingWidgets.buildSpotCard(
                  spots: BookingData.spots,
                  selectedSpot: selectedSpot,
                  onSelect: _selectSpot,
                ),
                const SizedBox(height: 20),

                // 4. كارت الدفع
                BookingWidgets.buildPaymentCard(
                  paymentMethod: selectedPayment,
                  onChange: _changePayment,
                ),
                const SizedBox(height: 20),

                // 5. ملخص الحساب
                BookingWidgets.buildSummaryCard(
                  parkingPrice: parkingPrice,
                  serviceFee: serviceFee,
                  totalPrice: totalPrice,
                  durationHours: durationHours,
                ),
                const SizedBox(height: 20),

                // 6. زر تأكيد الحجز
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _confirmBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1F36),
                      disabledBackgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: isLoading
                        ? const SizedBox(width: 25, height: 25, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text("أكد الحجز - ${_toArabicNumbers(totalPrice.toString())} ج.م", style: const TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // App Bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
          ),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("تأكيد الحجز", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
              Text("جراج سيتي سنتر", style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}