import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_color.dart';
import 'package:pooking_app/core/classes/app_text_style.dart';
import 'package:pooking_app/feature/parkingDetails/ui/row_continer.dart';
import 'package:pooking_app/feature/parkingDetails/ui/widget/features_list.dart';
import 'package:pooking_app/feature/parkingDetails/ui/widget/parking_grid.dart';
import 'package:pooking_app/feature/parkingDetails/ui/widget/parking_header.dart';
import 'package:pooking_app/feature/parkingDetails/ui/widget/row_of_squair.dart';

class ParkingDetailsScreen extends StatelessWidget {
  static const String routeName = "ParkingDetailsScreen";
  const ParkingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        backgroundColor: AppColor.mainColor,
        elevation: 0,
        title: const SizedBox.shrink(),
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ParkingHeader(),
                const SizedBox(height: 20),
                const Expanded(child: ParkingGrid()),
              ],
            ),
          ),
        ),
      ),

      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("جراج سيتي سنتر", style: AppTextStyle.bold24),
              const SizedBox(height: 10),
              const Text(
                "شارع التحرير، وسط البلد",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              const FeaturesList(),
              SizedBox(height: 40),
              RowOfSquair(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 8), 
                    const Text(
                      "مفتوح الآن - يعمل على مدار الساعة",
                      
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("أقصى ارتفاع للسيارة ٢٫٠ م"),
              ),
              SizedBox(height: 180,),
            RowContiner(),
            ],
          ),
        ),
      ),
    );
  }
}
