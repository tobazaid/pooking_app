import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  static const String routeName = "forget_password";
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // دالة إرسال رابط إعادة التعيين
  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (mounted) {
        setState(() => _isLoading = false);
        
        // رسالة نجاح
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("تم إرسال الرابط"),
            content: const Text("تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني. يرجى مراجعة صندوق الوارد (أو البريد المزعج)."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // غلق الرسالة
                  Navigator.pop(context); // الرجوع لشاشة تسجيل الدخول
                },
                child: const Text("حسناً"),
              ),
            ],
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        String message = 'حدث خطأ';
        if (e.code == 'user-not-found') {
          message = 'هذا الإيميل غير مسجل';
        } else if (e.code == 'invalid-email') {
          message = 'الإيميل غير صالح';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("نسيت كلمة المرور", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 30),
              
              // أيقونة توضيحية
              Center(
                child: Icon(Icons.lock_reset, size: 80, color: Colors.grey.shade300),
              ),
              const SizedBox(height: 30),

              // النص التوضيحي
              const Text(
                "أدخل بريدك الإلكتروني المسجل، وسنرسل لك رابطاً لإعادة تعيين كلمة المرور.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // حقل الإيميل
              const Text("البريد الإلكتروني", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "example@email.com",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "ادخل الإيميل";
                  if (!value.contains('@')) return "الإيميل غير صالح";
                  return null;
                },
              ),
              const SizedBox(height: 40),

              // زر الإرسال
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _resetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1F36),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("إرسال رابط إعادة التعيين", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}