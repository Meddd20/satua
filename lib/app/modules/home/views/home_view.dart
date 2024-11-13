import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:satua/app/core/theme_manager/assets_manager.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/modules/home/views/edit_profile_view.dart';
import 'package:satua/app/modules/home/views/user_guide_view.dart';
import 'package:satua/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.ellipsis_vertical),
            onPressed: () => Get.to(() => const EditProfileView()),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return Text(
                              'Hi ${controller.username.value}!',
                              style: TextStyleManager.titleGreen(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          }),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text(
                            'Mari ciptakan cerita sebelum tidur berasama dengan Satua.',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF666666)),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          const Text(
                            'Jelajahi',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.DETAILS),
                            child: Wrap(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  color: const Color(0xFF8FDEBC),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(25.0, 30.0, 20.0, 30.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Buat cerita baru',
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 14,
                                                ),
                                                Text(
                                                  'Dengan bantuan otak kreatif dari OpenAI, Satua dapat membantu kamu membuat cerita sebelum tidur yang pas untuk anak.',
                                                  maxLines: 4,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          '${AssetManager.imagePath}/cacing-kuning.png',
                                          height: 180,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.STORY_LIST),
                            child: Wrap(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  color: const Color(0xFFFFF08A),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(25.0, 30.0, 20.0, 30.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Koleksi cerita',
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 14,
                                                ),
                                                Text(
                                                  'Ingin melihat cerita yang pernah dibuat sebelumnya? Jelajahi hasil kreasi dan berpetualanglah kembali.',
                                                  maxLines: 4,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          '${AssetManager.imagePath}/cacing-hijau.png',
                                          height: 180,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.PROFILE_GALLERY),
                            child: Wrap(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  color: const Color(0xFFFFB18A),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(25.0, 30.0, 20.0, 30.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Profil anak',
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 14,
                                                ),
                                                Text(
                                                  'Lewati pengisian informasi anak saat membuat cerita ke depannya dengan membuat profil karakter anak.',
                                                  maxLines: 4,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          '${AssetManager.imagePath}/cacing-biru.png',
                                          height: 180,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            'Parenting 101',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 22),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.TRACKER),
                            child: Wrap(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  color: const Color(0xFFBED7FC),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(25.0, 30.0, 20.0, 30.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Progress Tracker',
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 14,
                                                ),
                                                Text(
                                                  'Lihat frekuensi anak berpartisipasi dalam bedtime story. Lihat hasil harian, mingguan, dan bulanan.',
                                                  maxLines: 4,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          '${AssetManager.imagePath}/kacang-merah.png',
                                          height: 180,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          GestureDetector(
                            onTap: () => Get.to(() => const UserGuideView()),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                              color: const Color(0xFFFFABD8),
                              child: const Padding(
                                padding: EdgeInsets.all(0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 30.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Panduan Penggunaan',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 14,
                                            ),
                                            Text(
                                              "Pelajari lebih lanjut cara menggunakan aplikasi agar kegiatan bedtime story menjadi seru dan optimal.",
                                              style: TextStyle(fontSize: 14),
                                              maxLines: 4,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            'Get to know us',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 22),
                          const Text(
                            'Selamat datang di Satua, tempat mimpi terbang dan cerita pengantar tidur menjadi hidup! 🌙✨\nDi Satua, kami percaya pada keajaiban cerita pengantar tidur dan kekuatan imajinasi. \n\nKami bukan hanya sebuah aplikasi; kami adalah teman bercerita Anda, di sini untuk membawa Anda ke dunia mempesona yang dibuat dengan cinta dan didukung oleh AI mutakhir. \n\nMisi kami sederhana: mengubah waktu tidur menjadi petualangan ajaib bagi anak-anak dan orang tua. Satua, yang berasal dari bahasa Indonesia untuk "cerita," lebih dari sekadar aplikasi; ini adalah pintu gerbang ke alam semesta di mana imajinasi tidak mengenal batas.',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF666666)),
                          ),
                          const SizedBox(height: 50),
                          GestureDetector(
                            onTap: () => controller.openWhatsAppChatWithNiKetutJeniAdhi(),
                            child: Wrap(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  color: const Color(0xFFDAF0C6),
                                  child: const Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 30.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Ingin bantuan profesional?',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 14,
                                              ),
                                              Text(
                                                "Ingin mengenali anak anda lebih jauh dengan bantuan profesional?",
                                                style: TextStyle(fontSize: 14),
                                                maxLines: 4,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "Lakukan pemesanan konsultasi dengan Psikolog Ni Ketut Jeni Adhi",
                                                style: TextStyle(fontSize: 14),
                                                maxLines: 4,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 77),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Copyright © 2024 Satua. All Rights Reserved.",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Color(0xFF666666)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
