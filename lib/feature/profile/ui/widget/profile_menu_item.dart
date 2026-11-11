
import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_text_style.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey.shade700,
            size: 23,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: AppTextStyle.profileMenu,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_back_ios,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
