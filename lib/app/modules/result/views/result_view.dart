import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/core/theme_manager/assets_manager.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/routes/app_pages.dart';

import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showStorySavedDialog(BuildContext context) {
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
                  "Cerita disimpan!",
                  style: TextStyleManager.titleGreen(fontSize: 24),
                ),
                const SizedBox(height: 15),
                Text(
                  "Cerita malam hari anda telah berhasil disimpan ke koleksi cerita. Tekan tombol di bawah untuk melihat petualangan lampau anda sebelumnya.",
                  style: TextStyleManager.regular12(fontSize: 14, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actionsPadding: const EdgeInsets.fromLTRB(35, 20, 35, 35),
            actions: [
              ElevatedButton(
                onPressed: () => Get.offAllNamed(Routes.STORY_LIST),
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
                  'Koleksi Cerita',
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
    }

    return Obx(
      () => Scaffold(
        appBar: AppBar(
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
          title: Text(
            'Buat Cerita',
            style: TextStyleManager.titleGreen(),
          ),
        ),
        body: controller.title.value != '' && controller.body.value != '' && controller.questions.value != ''
            ? SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      child: Text(
                        controller.title.value,
                        style: TextStyleManager.title(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      controller.body.value,
                      style: TextStyleManager.regular12(fontSize: 14),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: Get.width,
                      child: Text(
                        "Pertanyaan Reflektif:",
                        style: TextStyleManager.medium12(fontSize: 14, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(controller.questions.value),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: controller.isRead.value,
                            onChanged: (isRead) {
                              controller.isRead.value = isRead!;
                            },
                            activeColor: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Sudah selesai membaca",
                          style: TextStyleManager.regular12(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    if (controller.isEdited.value == true) ...[
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await controller.updateStory();
                            _showStorySavedDialog(context);
                          } catch (e) {
                            showToast("Terjadi kesalahan saat menyimpan cerita. Silakan coba lagi.");
                          }
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
                          'Edit Cerita!',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await controller.saveStory();
                            _showStorySavedDialog(context);
                          } catch (e) {
                            showToast("Terjadi kesalahan saat menyimpan cerita. Silakan coba lagi.");
                          }
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
                          'Buat Sebagai Cerita Baru!',
                          style: TextStyle(color: Color(0xFFBDBDBD), fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                    ] else ...[
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await controller.saveStory();
                            _showStorySavedDialog(context);
                          } catch (e) {
                            showToast("Terjadi kesalahan saat menyimpan cerita. Silakan coba lagi.");
                          }
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
                          'Buat Cerita!',
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
                    const SizedBox(height: 20),
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
              )
            : Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 150, height: 150, child: Image.asset('${AssetManager.imagePath}/awan-hijau.png')),
                            const SizedBox(height: 30),
                            Text(
                              'Tunggu sebentar',
                              style: TextStyleManager.titleGreen(),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: 250,
                              child: Text(
                                'Satua sedang membuat cerita \nsebelum tidur anda...',
                                textAlign: TextAlign.center,
                                style: TextStyleManager.medium12(fontSize: 14),
                              ),
                            ),
                            const SizedBox(height: 200),
                          ],
                        )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .effect(
                              duration: 3000.ms,
                            )
                            .effect(
                              delay: 750.ms,
                              duration: 1500.ms,
                            )
                            .fadeIn(
                              curve: Curves.easeOutCirc,
                            )
                            .untint(
                              color: Colors.white,
                            )
                            .blurXY(
                              begin: 16,
                            )
                            .scaleXY(
                              begin: 1.5,
                            ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Center(
                        child: Text(
                          "Copyright © 2024 Story.AI. All Rights Reserved.",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Color(0xFF666666)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
