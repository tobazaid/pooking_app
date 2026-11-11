
import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_text_style.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          "عبدالتواب",
          style: AppTextStyle.profileName,
        ),
        SizedBox(height: 3),
        Text(
          "01094746713",
          style: AppTextStyle.profilePhone,
        ),
      ],
    );
  }
}
