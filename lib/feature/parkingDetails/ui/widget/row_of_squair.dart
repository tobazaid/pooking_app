import 'package:flutter/material.dart';

class RowOfSquair extends StatelessWidget {
  const RowOfSquair({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // المربع الأول
                  Container(
                    width: 100, // كبرت العرض شوية عشان الكلام يبان
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.shade200,
                    ),
                    child: const Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // توسيط عمودي
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // توسيط أفقي
                      children: [
                        Text("الأماكن المتاحة", style: TextStyle(fontSize: 12)),
                        SizedBox(height: 5),
                        Text(
                          "12/40",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // المربع الثاني
                  Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.shade200,
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("سعر الساعة", style: TextStyle(fontSize: 12)),
                        SizedBox(height: 5),
                        Text(
                          "25 ج.م",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // المربع الثالث
                  Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.shade200,
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("المسافة", style: TextStyle(fontSize: 12)),
                        SizedBox(height: 5),
                        Text(
                          "350 م",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }
}