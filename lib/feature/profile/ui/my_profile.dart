
import 'package:flutter/material.dart';
import 'package:pooking_app/feature/profile/ui/widget/logout_button.dart';
import 'package:pooking_app/feature/profile/ui/widget/profile_header.dart';
import 'package:pooking_app/feature/profile/ui/widget/profile_menu_card.dart';
import 'package:pooking_app/feature/profile/ui/widget/profile_menu_item.dart';
class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: const ProfileHeader(),

        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade400,
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 30,
          ),
          children: [
            ProfileMenuCard(
              height: 226,
              items: const [
                ProfileMenuItem(
                  icon: Icons.person,
                  title: "بياناتي الشخصية",
                ),
                ProfileMenuItem(
                  icon: Icons.car_crash,
                  title: "سيارتي",
                ),
                ProfileMenuItem(
                  icon: Icons.credit_card,
                  title: "طرق الدفع",
                ),
              ],
            ),

            const SizedBox(height: 20),

            ProfileMenuCard(
              height: 113,
              items: const [
                ProfileMenuItem(
                  icon: Icons.info_outline,
                  title: "المساعدة والدعم",
                ),
                ProfileMenuItem(
                  icon: Icons.shield_outlined,
                  title: "الشروط والخصوصية",
                ),
              ],
            ),

            const SizedBox(height: 20),

            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
