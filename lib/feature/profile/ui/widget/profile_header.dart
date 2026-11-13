import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_text_style.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String phone;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name, style: AppTextStyle.profileName),
        const SizedBox(height: 3),
        Text(phone, style: AppTextStyle.profilePhone),
      ],
    );
  }
}