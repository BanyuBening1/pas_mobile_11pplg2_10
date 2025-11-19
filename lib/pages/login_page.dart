import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_10/controller/auth_controller.dart';
import 'package:pas_mobile_11pplg2_10/routes/routes.dart';
import 'package:pas_mobile_11pplg2_10/widget/myButton.dart';
import 'package:pas_mobile_11pplg2_10/widget/myTextField.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController userC = TextEditingController();
    final TextEditingController passC = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Placeholder
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline,
                    size: 70,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),

                Text(
                  "Masuk ke akun Anda",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 32),

                /// Username
                Mytextfield(label: "Username", controller: userC),
                const SizedBox(height: 16),

                /// Password
                Mytextfield(
                  label: "Password",
                  controller: passC,
                  isPassword: true,
                ),
                const SizedBox(height: 28),

                /// Tombol Login
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.login(userC.text, passC.text),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.3,
                              ),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// Text + Button Register
                Column(
                  children: [
                    Text(
                      "Belum punya akun?",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Mybutton(
                      text: "Daftar Sekarang",
                      onPressed: () => Get.offAllNamed(AppRoutes.registPage),
                      height: 50,
                      width: double.infinity, // biar responsif
                      backgroundColor: Colors.blue.shade50,
                      textColor: Colors.blue.shade700,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
