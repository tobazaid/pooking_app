import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_color.dart';
import 'package:pooking_app/feature/auth/login/ui/login_screen.dart'; // <--- ضفنا الاستدعاء ده
import 'package:pooking_app/feature/auth/regiter/ui/widget/custom_password_field.dart';
import 'package:pooking_app/feature/auth/regiter/ui/widget/custom_text_field.dart';
import 'package:pooking_app/feature/auth/regiter/ui/widget/register_header.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register_screen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // دالة إنشاء الحساب بالإيميل والباسورد
  Future<void> _registerWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // 1. إنشاء المستخدم في Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 2. حفظ الاسم في Firestore
      if (userCredential.user != null) {
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        // 3. تحديث اسم المستخدم في الـ Auth
        await userCredential.user!.updateDisplayName(_nameController.text.trim());
      }

      // 4. الانتقال لشاشة تسجيل الدخول (بدل الـ Home)
      if (mounted) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'حدث خطأ';
      if (e.code == 'weak-password') {
        errorMessage = 'كلمة المرور ضعيفة جداً';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'هذا الإيميل مسجل بالفعل';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'الإيميل غير صالح';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل إنشاء الحساب: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const RegisterHeader(),
                  const SizedBox(height: 30),

                  // 1. حقل الاسم
                  const Text("الاسم الكامل", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hint: "الاسم",
                    controller: _nameController,
                    validator: (value) => value!.isEmpty ? "ادخل اسمك" : null,
                  ),
                  const SizedBox(height: 20),

                  // 2. حقل الإيميل
                  const Text("البريد الإلكتروني", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hint: "example@email.com",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "ادخل الإيميل";
                      if (!value.contains('@')) return "الإيميل غير صالح";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // 3. حقل الباسورد
                  const Text("كلمة المرور", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  CustomPasswordField(
                    hint: "ادخل كلمة المرور",
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "ادخل كلمة المرور";
                      if (value.length < 6) return "كلمة المرور قصيرة (6 أحرف على الأقل)";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // 4. حقل تأكيد الباسورد
                  const Text("تأكيد كلمة المرور", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  CustomPasswordField(
                    hint: "أعد كتابة كلمة المرور",
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return "كلمة المرور غير متطابقة";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),

                  // زرار إنشاء الحساب
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _registerWithEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mainColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "إنشاء الحساب",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}