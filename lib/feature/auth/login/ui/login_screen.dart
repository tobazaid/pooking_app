import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pooking_app/core/classes/app_color.dart';
import 'package:pooking_app/core/classes/app_text_style.dart';
import 'package:pooking_app/core/custems/custem_botoom.dart';
import 'package:pooking_app/feature/auth/login/ui/widget/continerP_login_screen.dart';
import 'package:pooking_app/feature/auth/login/ui/widget/row_apple_google.dart';
import 'package:pooking_app/feature/auth/login/ui/widget/row_text.dart';
import 'package:pooking_app/feature/auth/regiter/ui/widget/custom_password_field.dart'; // استخدمنا الحقل الجاهز
import 'package:pooking_app/feature/auth/regiter/ui/widget/custom_text_field.dart';
import 'package:pooking_app/feature/forgetPassword/ui/forget_password.dart';
import 'package:pooking_app/feature/home/ui/home_screen.dart'; // استخدمنا الحقل الجاهز

class LoginScreen extends StatefulWidget {
  static const String routeName = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          HomeScreen.routeName,
        ); // يدخل على الهوم
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'حدث خطأ';
      if (e.code == 'user-not-found') {
        errorMessage = 'هذا الإيميل غير مسجل';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'كلمة المرور غير صحيحة';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'الإيميل غير صالح';
      }
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const ContinerpLoginScreen(),
                  const SizedBox(height: 25),
                  Text("أهلاً بيك  👋", style: AppTextStyle.extrabold),
                  const SizedBox(height: 8),
                  Text(
                    "سجّل دخولك عشان تحجز مكانك في ثواني",
                    style: AppTextStyle.regular,
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 28, 22, 25),
                  child: Form(
                    // 1. تغليف الحقول بالـ Form
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // 2. حقل الإيميل
                        const Text(
                          "البريد الإلكتروني",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF252525),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          hint: "example@email.com",
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "ادخل الإيميل";
                            if (!value.contains('@')) return "الإيميل غير صالح";
                            return null;
                          },
                        ),

                        const SizedBox(height: 22),

                        // 3. حقل الباسورد
                        const Text(
                          "كلمة المرور",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF252525),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomPasswordField(
                          hint: "ادخل كلمة المرور",
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "ادخل كلمة المرور";
                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        GestureDetector(
                          onTap: () {},
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ForgetPassword.routeName,
                              );
                            },
                            child: const Text(
                              "هل نسيت كلمة المرور؟",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // 4. زرار الدخول
                        CustemBotoom(
                          text: _isLoading ? "جاري التحميل..." : "تسجيل الدخول",
                          onTap: _isLoading ? () {} : _login,
                          backgroundColor: AppColor.mainColor,
                          textColor: Colors.white,
                        ),

                        const SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(color: Colors.grey.shade300),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                "أو تابع باستخدام",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(color: Colors.grey.shade300),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        RowAppleGoogle(),

                        const SizedBox(height: 35),

                        Center(child: RowText()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
