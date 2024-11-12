import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:satua/app/core/theme_manager/assets_manager.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Image.asset(
                          '${AssetManager.imagePath}/awan-kuning.png',
                          height: 113,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Email', style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(fontSize: 12.0, color: Color(0xFF666666)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Kata Sandi', style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                          const SizedBox(height: 8.0),
                          Obx(
                            () => TextFormField(
                              controller: controller.passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: controller.obscurePassword.value,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(fontSize: 12.0, color: Color(0xFF666666)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => controller.obscurePassword.value = !controller.obscurePassword.value,
                                  icon: Icon(
                                    controller.obscurePassword.value ? Icons.visibility_off : Icons.visibility,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nama', style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: controller.usernameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(fontSize: 12.0, color: Color(0xFF666666)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: controller.register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00B567),
                          textStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text(
                          'Daftar',
                          style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 26),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.LOGIN),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Sudah ada akun?', style: TextStyleManager.mediumGray()),
                            Text(
                              ' Masuk sekarang!',
                              style: TextStyleManager.mediumGray(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                    ],
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Text(
                    "Copyright © 2024 Story.AI. All Rights Reserved.",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Color(0xFF666666)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
