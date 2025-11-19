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
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Mytextfield(label: "Username", controller: controller.usernameController, keyboardType: TextInputType.name,),
              const SizedBox(height: 16),

              Mytextfield(label: "Password", controller: controller.passwordController, isPassword: true,),
              const SizedBox(height: 16),

              Mytextfield(label: "Email", controller: controller.emailController, keyboardType: TextInputType.emailAddress,),
              const SizedBox(height: 16),

              Mytextfield(label: "Full Name", controller: controller.fullNameController,),
              const SizedBox(height: 24),

              Obx(() {
                return Mybutton(
                  text: 'Register',
                  onPressed: controller.register,
                  isLoading: controller.isLoading.value,
                  icon: Icons.login,
                  height: 54,
                );
              }),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.loginPage);
                },
                child: const Text('Sudah punya akun? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
