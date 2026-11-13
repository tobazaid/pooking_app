import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pooking_app/feature/profile/ui/widget/logout_button.dart';
import 'package:pooking_app/feature/profile/ui/widget/profile_header.dart';
import 'package:pooking_app/feature/profile/ui/widget/profile_menu_card.dart';
import 'package:pooking_app/feature/profile/ui/widget/profile_menu_item.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String _name = "جاري التحميل...";
  String _phone = "...";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // جلب البيانات من Firebase
  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (mounted) {
        setState(() {
          _name = "غير مسجل";
          _phone = "غير مسجل";
          _isLoading = false;
        });
      }
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (mounted) {
        setState(() {
          _name = doc.data()?['name'] ?? user.displayName ?? "مستخدم";
          _phone = doc.data()?['phone'] ?? "لا يوجد رقم";
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _name = user.displayName ?? "مستخدم";
          _phone = "لا يوجد رقم";
          _isLoading = false;
        });
      }
    }
  }

  // تعديل البيانات (الاسم والموبايل بس)
  Future<void> _editProfile() async {
    final nameController = TextEditingController(text: _name);
    final phoneController = TextEditingController(text: _phone);

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("تعديل الملف الشخصي"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // حقل الاسم
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "الاسم"),
              ),
              const SizedBox(height: 10),
              // حقل الموبايل
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "رقم الموبايل"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user == null) return;

              try {
                // 1. تحديث الاسم في Auth
                if (nameController.text.trim().isNotEmpty) {
                  await user.updateDisplayName(nameController.text.trim());
                }

                // 2. تحديث البيانات في Firestore (الاسم والموبايل بس)
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .update({
                  'name': nameController.text.trim(),
                  'phone': phoneController.text.trim(),
                });

                if (mounted) {
                  setState(() {
                    _name = nameController.text.trim();
                    _phone = phoneController.text.trim();
                  });
                  Navigator.pop(dialogContext);
                }
              } catch (e) {
                print("================================");
                print("ERROR IN UPDATE: $e");
                print("================================");

                if (mounted) {
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("فشل التحديث: $e")),
                  );
                }
              }
            },
            child: const Text("حفظ"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: ProfileHeader(name: _name, phone: _phone),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade400,
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _editProfile,
            icon: const Icon(Icons.edit, color: Colors.black),
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                children: [
                  ProfileMenuCard(
                    height: 226,
                    items: const [
                      ProfileMenuItem(icon: Icons.person, title: "بياناتي الشخصية"),
                      ProfileMenuItem(icon: Icons.car_crash, title: "سيارتي"),
                      ProfileMenuItem(icon: Icons.credit_card, title: "طرق الدفع"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProfileMenuCard(
                    height: 113,
                    items: const [
                      ProfileMenuItem(icon: Icons.info_outline, title: "المساعدة والدعم"),
                      ProfileMenuItem(icon: Icons.shield_outlined, title: "الشروط والخصوصية"),
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