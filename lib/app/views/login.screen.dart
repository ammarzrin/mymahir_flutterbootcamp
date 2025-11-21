import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutter_nov2025/app/controllers/login.controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Center(
        child: Card(
          color: Colors.cyan,
          margin: EdgeInsets.all(32),
          child: Column(
            mainAxisSize: .min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 32),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Login',
                  textAlign: .center,
                  style: TextStyle(fontSize: 50, fontWeight: .bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Email'),
                    hintText: 'Please enter your email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Obx(
                  () => TextField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Password'),
                      hintText: 'Please enter your password',
                      suffixIcon: IconButton(
                        onPressed: controller.togglePasswordView,
                        icon: controller.showPassword.value
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.showPassword.value,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ElevatedButton(
                  onPressed: controller.onLogin,
                  child: Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
