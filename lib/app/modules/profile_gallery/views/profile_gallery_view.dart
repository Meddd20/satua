import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/modules/profile_gallery/views/profile_form_view.dart';
import 'package:satua/app/routes/app_pages.dart';

import '../controllers/profile_gallery_controller.dart';

class ProfileGalleryView extends GetView<ProfileGalleryController> {
  const ProfileGalleryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                Get.offAllNamed(Routes.HOME);
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profil Anak',
                        style: TextStyleManager.title(),
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        width: 140,
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          value: controller.selectedSortOption.value.isNotEmpty ? controller.selectedSortOption.value : null,
                          onChanged: (String? newValue) {
                            controller.selectedSortOption.value = newValue!;
                            controller.sortProfiles();
                          },
                          hint: const Text('Urutkan'),
                          style: TextStyleManager.mediumGray12(),
                          icon: const Icon(Icons.arrow_drop_down, size: 24.0),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
                            ),
                          ),
                          items: ['Sort by A from Z', 'Sort by Z from A', 'Newest', 'Oldest'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: 150,
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),
                  Obx(
                    () => Column(
                      children: List.generate(
                        controller.allProfile.length,
                        (index) {
                          final profile = controller.allProfile[index];
                          return Container(
                            width: Get.width,
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: ListTile(
                                  onTap: () => Get.to(() => const ProfileFormView(), arguments: profile),
                                  title: Text(
                                    profile.childsName,
                                    style: TextStyleManager.medium12(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => Get.to(() => const ProfileFormView()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFDE00),
                      textStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                      minimumSize: Size(Get.width, 50),
                    ),
                    child: const Text(
                      'Buat Profil Baru',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 85),
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
            ],
          ),
        ),
      ),
    );
  }
}
