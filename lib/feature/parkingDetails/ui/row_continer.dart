import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_color.dart';
import 'package:pooking_app/feature/Booking_confirmation/ui/booking_confirmation.dart';

class RowContiner extends StatelessWidget {
  const RowContiner({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 235,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.mainColor,
          ),
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, BookingConfirmation.routeName);
              },
              child: Text(
                "احجز مكان",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreenAccent,
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Text(" ابتداءً من"),
            Text(
              "٢٥ ج.م / ساعة",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
