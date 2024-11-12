import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satua/app/routes/app_pages.dart';
import 'package:satua/app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
  final AuthService authService = AuthService();
  final nameController = TextEditingController();

  RxBool isShowUsername = true.obs;

  bool get getIsShowUsername => isShowUsername.value;
  void setIsShowUsername(bool value) {
    isShowUsername.value = value;
  }

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('username') ?? '';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await authService.updateUsername(nameController.text);
    prefs.setBool('isShowUsername', isShowUsername.value);
    Get.offAllNamed(Routes.HOME);
  }
}
