
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  Future<String> createBooking({
    required String carName,
    required String carNumber,
    required String parkingSpot,
    required DateTime startAt,
    required int durationHours,
    required int parkingPrice,
    required int serviceFee,
    required int totalPrice,
    required String paymentMethod,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    if (durationHours < 1) {
      throw Exception('مدة الحجز غير صحيحة');
    }

    final endAt = startAt.add(
      Duration(hours: durationHours),
    );

    // Create booking reference
    final bookingRef = _firestore
        .collection('bookings')
        .doc();

    // Create a unique document for every occupied hour
    final slotRefs = List.generate(
      durationHours,
      (index) {
        final slotTime = startAt.add(
          Duration(hours: index),
        );

        final dateKey =
            '${slotTime.year}'
            '${slotTime.month.toString().padLeft(2, '0')}'
            '${slotTime.day.toString().padLeft(2, '0')}';

        final hourKey =
            slotTime.hour.toString().padLeft(2, '0');

        final slotId =
            '${dateKey}_${parkingSpot}_$hourKey';

        return _firestore
            .collection('parking_slots')
            .doc(slotId);
      },
    );

    await _firestore.runTransaction((transaction) async {
      // Read all slots before writing
      final snapshots = <DocumentSnapshot>[];

      for (final slotRef in slotRefs) {
        snapshots.add(
          await transaction.get(slotRef),
        );
      }

      // Check availability
      for (final snapshot in snapshots) {
        if (snapshot.exists) {
          throw Exception(
            'المكان $parkingSpot محجوز في هذا الوقت، اختر مكاناً آخر',
          );
        }
      }

      // Save booking
      transaction.set(bookingRef, {
        'bookingId': bookingRef.id,
        'userId': user.uid,
        'carName': carName,
        'carNumber': carNumber,
        'parkingSpot': parkingSpot,
        'startAt': Timestamp.fromDate(startAt),
        'endAt': Timestamp.fromDate(endAt),
        'durationHours': durationHours,
        'parkingPrice': parkingPrice,
        'serviceFee': serviceFee,
        'totalPrice': totalPrice,
        'paymentMethod': paymentMethod,
        'paymentStatus': 'unpaid',
        'bookingStatus': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Reserve selected parking hours
      for (final slotRef in slotRefs) {
        transaction.set(slotRef, {
          'bookingId': bookingRef.id,
          'userId': user.uid,
          'parkingSpot': parkingSpot,
          'bookingStatus': 'pending',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    });

    return bookingRef.id;
  }
}
