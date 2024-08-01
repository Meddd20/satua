import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/services/auth_service.dart';

class RegisterController extends GetxController {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Rx<bool> obscurePassword = Rx<bool>(true);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  void register() async {
    if (emailController.text.isEmpty) {
      showToast('Email cannot be empty');
      return;
    }

    if (!emailController.text.isEmail) {
      showToast('Invalid email format');
      return;
    }

    if (passwordController.text.isEmpty) {
      showToast('Password cannot be empty');
      return;
    }

    if (usernameController.text.isEmpty) {
      showToast('Username cannot be empty');
      return;
    }
    authService.registerAccount(emailController.text.trim(), passwordController.text.trim(), usernameController.text.trim());
  }
}
