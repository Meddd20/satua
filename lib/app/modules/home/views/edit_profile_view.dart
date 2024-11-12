import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:satua/app/common/satua_text_form_field.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/modules/home/controllers/edit_profile_controller.dart';
import 'package:satua/app/routes/app_pages.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(EditProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Orang Tua',
          style: TextStyleManager.titleGreen(),
        ),
        leading: Row(
          children: [
            const SizedBox(width: 5),
            IconButton(onPressed: () => Get.offAllNamed(Routes.HOME), icon: const Icon(Icons.close)),
          ],
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                SatuaTextFormFieldWidget(
                  title: 'Nama:',
                  controller: controller.nameController,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Obx(
                      () => SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          value: controller.isShowUsername.value,
                          onChanged: (isShow) {
                            controller.setIsShowUsername(isShow ?? true);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('Tunjukkan nama pada halaman utama?', style: TextStyleManager.mediumGray(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 45),
                ElevatedButton(
                  onPressed: () => controller.updateProfile(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFDE00),
                    textStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    minimumSize: const Size.fromHeight(50),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: const Color(0xFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          title: Column(
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                "Konfirmasi Logout",
                                style: TextStyleManager.titleGreen(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "Apakah Anda yakin ingin keluar?",
                                style: TextStyleManager.regular12(fontSize: 14, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          actionsPadding: const EdgeInsets.fromLTRB(35, 20, 35, 35),
                          actions: [
                            ElevatedButton(
                              onPressed: () => Get.back(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFDE00),
                                textStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                                minimumSize: const Size.fromHeight(50),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Batal',
                                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => controller.authService.logout(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF6F6F6),
                                textStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                                minimumSize: const Size.fromHeight(50),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Keluar',
                                style: TextStyle(color: Color(0xFFBDBDBD), fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF6F6F6),
                    textStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    minimumSize: const Size.fromHeight(50),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Keluar dari Akun',
                    style: TextStyle(color: Color(0xFFBDBDBD), fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
