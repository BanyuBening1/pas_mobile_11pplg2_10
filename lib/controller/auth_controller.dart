import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pas_mobile_11pplg2_10/model/login_model.dart';
import 'package:pas_mobile_11pplg2_10/model/regist_model.dart';
import 'package:pas_mobile_11pplg2_10/routes/routes.dart';
import 'package:pas_mobile_11pplg2_10/services/baseUrl.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();

  var registerResponse = Rxn<RegistModel>();
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  Future<dynamic> login(String username, String password) async {
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
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    final usernameTs = usernameController.text.trim();
    final passwordTs = passwordController.text.trim();
    final fullNameTs = fullNameController.text.trim();
    final emailTs = emailController.text.trim();

    final url = Uri.parse("${Baseurl.authUrl}/latihan/register-user");

    try {
      isLoading.value = true;

      final res = await http.post(
        url,
        body: {
          "username": usernameTs,
          "password": passwordTs,
          "full_name": fullNameTs,
          "email": emailTs,
        },
      );

      if (res.statusCode == 200) {
        final registerModel = registerModelFromJson(res.body);
        registerResponse.value = registerModel;

        if (registerModel.status == true) {
          Get.snackbar("Register", registerModel.message);
          usernameController.clear();
          passwordController.clear();
          Get.offAllNamed(AppRoutes.loginPage);
        } else {
          Get.snackbar("Register", registerModel.message);
        }
      } else {
        Get.snackbar("Register", "Register Gagal: Status ${res.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Register", "Koneksi gagal");
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("token");
    Get.snackbar(
      "Information",
      "Logout successfuly",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
    Get.offAllNamed(AppRoutes.loginPage);
  }
}
