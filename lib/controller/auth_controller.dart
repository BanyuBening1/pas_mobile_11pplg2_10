import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_10/model/login_model.dart';
import 'package:pas_mobile_11pplg2_10/routes/routes.dart';
import 'package:pas_mobile_11pplg2_10/services/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  var username = ''.obs;
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  Future <dynamic> login(String username, String password) async {
    try {
      isLoading.value = true;

      final url = Uri.parse("${Baseurl.authUrl}/latihan/login");
      final response = await http.post(
        url,
        body: {'username': username, 'password': password},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == true) {
        final model = LoginModel.fromJson(data);
        final pref = await SharedPreferences.getInstance();

        await pref.setString("token", model.token);
        await pref.setString("username", username);
        await pref.setBool("isLoggedIn", true);
        isLoggedIn.value = true;

        Get.snackbar("Success", "Selamat datang, $username!");
        Get.offAllNamed(AppRoutes.dashboardPage);
      } else {
        Get.snackbar("Error", data["message"] ?? "Login gagal");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> register() async {
    final usernameText = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final fullName = fullNameController.text.trim();

    if (usernameText.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        fullName.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua field harus diisi, tidak boleh ada yang kosong',
      );
    }

    final url = Uri.parse('${Baseurl.authUrl}/register-user');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'username': usernameText,
          'password': password,
          'full_name': fullName,
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        Get.offAllNamed(AppRoutes.loginPage);
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', usernameText);

          username.value = usernameText;
          isLoggedIn.value = true;

          return {
            'success': true,
            'message': data['message'] ?? 'Registrasi berhasil',
          };
        }

        return {
          'success': false,
          'message': data['message'] ?? 'Registrasi gagal',
        };
      }

      return {
        'success': false,
        'message': 'Registrasi gagal (${response.statusCode})',
      };
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }
}
