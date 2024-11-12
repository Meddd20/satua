import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/common/satua_text_form_field.dart';
import 'package:satua/app/modules/profile_gallery/controllers/profile_form_controller.dart';
import 'package:satua/app/routes/app_pages.dart';

class ProfileFormView extends GetView<ProfileFormController> {
  const ProfileFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileFormController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Anak',
          style: TextStyleManager.titleGreen(),
        ),
        centerTitle: true,
        leading: Row(
          children: [
            const SizedBox(width: 5),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        actions: controller.isEditMode == true
            ? [
                PopupMenuButton(
                  onSelected: (String value) {
                    if (value == 'Delete') {
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
                                  "Hapus profile?",
                                  style: TextStyleManager.titleGreen(fontSize: 24),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "Profil anak yang telah dihapus, tidak bisa digunakan kembali. Apakah anda tetap ingin menghapus profil?",
                                  style: TextStyleManager.regular12(fontSize: 14, fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            actionsPadding: const EdgeInsets.fromLTRB(35, 20, 35, 35),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
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
                                onPressed: () => controller.deleteProfile(controller.detailProfile?.id ?? ""),
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
                                  'Hapus Profil',
                                  style: TextStyle(color: Color(0xFFBDBDBD), fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'Delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                )
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 15),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SatuaTextFormFieldWidget(
                  title: "Nama anak:",
                  controller: controller.childsName,
                ),
                const SizedBox(height: 15),
                const Text("Tanggal Lahir:", style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: controller.getBirthDate ?? DateTime.now(),
                      firstDate: DateTime(1985),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      controller.setBirthDate(value);
                    });
                  },
                  child: Obx(
                    () => Container(
                      height: 60,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: const Color(0xFFE8E8E8),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.getBirthDate != null ? DateFormat('dd MMMM yyyy').format(controller.getBirthDate!) : "",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text("Age:", style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                const SizedBox(height: 8.0),
                Obx(
                  () => Container(
                    height: 60,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: const Color(0xFFE8E8E8),
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.age.value?.toString() ?? '',
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Gender:", style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                    const SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: controller.selectedGender.value.isNotEmpty ? controller.selectedGender.value : null,
                      onChanged: (String? newValue) {
                        controller.selectedGender.value = newValue!;
                      },
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
                      items: ['Male', 'Female', 'Non Binary'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                SatuaTextFormFieldWidget(
                  title: 'Neurodevelopmental Disorder:',
                  controller: controller.neurodevelopmentalDisorder,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    await controller.createNewProfile();
                    showDialog(
                      barrierDismissible: false,
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
                                "Profil Dibuat",
                                style: TextStyleManager.titleGreen(fontSize: 24),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "Selamat! Anda telah berhasil membuat profil baru untuk anak Anda. Ini akan mempermudah dan mempercepat proses pembuatan cerita Anda di waktu berikutnya!",
                                style: TextStyleManager.regular12(fontSize: 14, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          actionsPadding: const EdgeInsets.fromLTRB(35, 20, 35, 35),
                          actions: [
                            ElevatedButton(
                              onPressed: () => Get.offAllNamed(Routes.PROFILE_GALLERY),
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
                                'Profil Anak',
                                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => Get.offAllNamed(Routes.HOME),
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
                                'Halaman Utama',
                                style: TextStyle(color: Color(0xFFBDBDBD), fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFDE00),
                    textStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    minimumSize: Size(Get.width, 50),
                  ),
                  child: Text(
                    controller.isEditMode == true ? "Simpan Perubahan" : 'Buat Profile Baru',
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
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
    );
  }
}
