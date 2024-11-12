import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
  }

  void login() {
    if (emailController.text.isEmpty) {
      showToast('Email tidak boleh kosong');
      return;
    }

    if (!emailController.text.isEmail) {
      showToast('Format email tidak valid');
      return;
    }

    if (passwordController.text.isEmpty) {
      showToast('Kata sandi tidak boleh kosong');
      return;
    }

    authService.loginAccount(emailController.text.trim(), passwordController.text.trim());
  }
}
