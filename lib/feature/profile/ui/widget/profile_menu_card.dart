
import 'package:flutter/material.dart';
import 'profile_menu_item.dart';

class ProfileMenuCard extends StatelessWidget {
  final double height;
  final List<ProfileMenuItem> items;

  const ProfileMenuCard({
    super.key,
    required this.height,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }
}
