import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_10/controller/auth_controller.dart';
import 'package:pas_mobile_11pplg2_10/routes/routes.dart';
import 'package:pas_mobile_11pplg2_10/widget/myButton.dart';
import 'package:pas_mobile_11pplg2_10/widget/myTextField.dart';

class RegistPage extends StatelessWidget {
  const RegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Daftar Akun"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),

            Center(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_add_alt_1,
                  size: 70,
                  color: Colors.blue.shade700,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                "Buat Akun Baru",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 6),

            Center(
              child: Text(
                "Isi data lengkap Anda untuk mendaftar",
                style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
              ),
            ),

            const SizedBox(height: 32),

            Mytextfield(
              label: "Username",
              controller: controller.usernameController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),

            Mytextfield(
              label: "Password",
              controller: controller.passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 16),

            Mytextfield(
              label: "Email",
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            Mytextfield(
              label: "Full Name",
              controller: controller.fullNameController,
            ),
            const SizedBox(height: 28),

            Obx(
              () => Mybutton(
                text: 'Register',
                onPressed: controller.register,
                isLoading: controller.isLoading.value,
                icon: Icons.person_add_alt_1,
                height: 54,
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: TextButton(
                onPressed: () => Get.offAllNamed(AppRoutes.loginPage),
                child: Text(
                  'Sudah punya akun? Login',
                  style: TextStyle(color: Colors.blue.shade700, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
