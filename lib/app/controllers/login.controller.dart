import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:dio/dio.dart';
import 'package:myflutter_nov2025/app/services/api.service.dart';
import 'package:myflutter_nov2025/app/services/sharedprefs.dart';
import 'package:myflutter_nov2025/app/widgets/navbar.widget.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final showPassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordView() {
    showPassword.value = !showPassword.value;
    if (showPassword.value == true) {}
  }

  Future<void> onLogin() async {
    FormData formData = FormData.fromMap({
      'email': emailController.text,
      'password': passwordController.text,
    });

    try {
      var res = await api.postDio('/auth/login', formData);
      if (res != null && res.statusCode == 200) {
        final data = res.data;
        final String token = data['token'];
        final Map<String, dynamic> user = data['user'] ?? {};
        String userString = jsonEncode(user);
        await SharedPrefs.setLocalStorage('token', token);
        await SharedPrefs.setLocalStorage('user', userString);

        Get.off(() => NavBar());
      }
    } on DioException catch (dioError) {
      log('API error ${dioError.toString()}');
      Get.snackbar('Login Failed', dioError.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
