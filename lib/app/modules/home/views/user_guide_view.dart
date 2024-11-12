import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:satua/app/common/bullet_list.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/routes/app_pages.dart';

class UserGuideView extends GetView {
  const UserGuideView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Panduan Penggunaan',
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
            floating: true,
            pinned: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    "Perkenalkan Satua,",
                    style: TextStyleManager.title(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Aplikasi ini dirancang untuk membantu Anda menciptakan cerita pengantar tidur yang menarik dan disesuaikan dengan kebutuhan anak Anda.",
                    style: TextStyleManager.regular12(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Penting:",
                    style: TextStyleManager.medium12(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Meskipun aplikasi ini menghasilkan cerita secara otomatis, peran serta orang tua tetaplah penting.",
                    style: TextStyleManager.regular12(fontSize: 14),
                  ),
                  const BulletList(bulletListText: "Batasi waktu layar anak dengan membacakan cerita secara langsung pada anak."),
                  const BulletList(bulletListText: "Gunakan gestur, tunjukkan kasih sayang, dan membangun ikatan dengan anak Anda."),
                  const SizedBox(height: 30),
                  Text(
                    "Membuat Cerita Baru:",
                    style: TextStyleManager.medium12(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 15),
                  const BulletList(bulletListText: 'Untuk membuat cerita baru, ketuk tombol "Buat Cerita Baru".'),
                  const BulletList(bulletListText: "Anda akan dipandu untuk memilih berbagai elemen cerita, seperti tokoh utama, latar belakang, pesan moral, dan lainnya."),
                  const BulletList(bulletListText: "Cerita akan dihasilkan setelah beberapa detik, bacakan cerita pada anak dengan kegiatan bed time story."),
                  const BulletList(bulletListText: 'Setelah selesai membaca, tanyakan pertanyaan refleksi pada anak dan tandai "Saya sudah selesai membaca".'),
                  const SizedBox(height: 30),
                  Text(
                    "Mengakses Koleksi Cerita:",
                    style: TextStyleManager.medium12(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 15),
                  const BulletList(bulletListText: 'Untuk membaca kembali cerita yang telah dibuat, ketuk tombol "Koleksi Cerita".'),
                  const BulletList(bulletListText: "Anda dapat melihat daftar semua cerita yang telah dibuat dan memilih cerita yang ingin dibaca."),
                  const SizedBox(height: 30),
                  Text(
                    "Membuat Profil Anak:",
                    style: TextStyleManager.medium12(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 15),
                  const BulletList(bulletListText: 'Untuk membuat profil anak, ketuk tombol "Profil Anak".'),
                  const BulletList(bulletListText: "Isi data anak Anda, seperti nama, tanggal lahir, usia, dan jenis gangguan perkembangan saraf (jika ada)."),
                  const BulletList(bulletListText: 'Informasi ini akan membantu aplikasi dalam menghasilkan cerita yang sesuai dengan kebutuhan anak Anda.'),
                  const SizedBox(height: 30),
                  Text(
                    "Melihat Laporan Kemajuan Membaca:",
                    style: TextStyleManager.medium12(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 15),
                  const BulletList(bulletListText: 'Untuk melihat seberapa sering anak Anda membaca cerita, ketuk tombol "Progress Tracker".'),
                  const BulletList(bulletListText: 'Laporan ini akan menampilkan informasi tentang frekuensi membaca anak Anda.'),
                  const SizedBox(height: 30),
                  Text(
                    "Pengaturan Akun:",
                    style: TextStyleManager.medium12(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 15),
                  const BulletList(bulletListText: "Untuk keluar dari aplikasi atau mengubah nama tampilan Anda, klik tombol kebab (tiga titik vertikal) di pojok kanan atas layar."),
                  const BulletList(bulletListText: 'Anda akan menemukan opsi untuk keluar dan mengubah nama tampilan di menu tersebut.'),
                  const SizedBox(height: 30),
                  Text(
                    "Semoga panduan ini membantu Anda menggunakan aplikasi ini. Selamat menikmati waktu bercerita bersama anak Anda!",
                    style: TextStyleManager.regular12(fontSize: 14),
                  ),
                  const SizedBox(height: 77),
                  const Center(
                    child: Text(
                      "Copyright © 2024 Story.AI. All Rights Reserved.",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Color(0xFF666666)),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
