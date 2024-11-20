import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:satua/app/common/satua_text_form_field_randomizer.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/model/profile_model.dart';
import 'package:satua/app/common/satua_text_form_field.dart';

import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buat Cerita',
          style: TextStyleManager.titleGreen(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => controller.fetchLastCreatedStory(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xFFE8E8E8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Tampilkan isian sebelumnya",
                          style: TextStyleManager.mediumGray12(),
                        ),
                      ),
                    ),
                  ),
                ),
                const Text("Nama anak:", style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                const SizedBox(height: 8.0),
                TypeAheadField<Profile>(
                  builder: (context, controller, focusNode) {
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
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
                    );
                  },
                  hideOnEmpty: true,
                  controller: controller.nameController,
                  itemBuilder: (context, Profile profile) {
                    return ListTile(
                      title: Text(profile.childsName),
                    );
                  },
                  suggestionsCallback: (pattern) async {
                    await controller.fetchAllProfile();
                    return controller.allProfile.where((profile) {
                      return profile.childsName.toLowerCase().contains(pattern.toLowerCase());
                    }).toList();
                  },
                  onSelected: (selectedProfile) {
                    controller.nameController.text = selectedProfile.childsName;
                    controller.ageController.text = selectedProfile.age.toString();
                    controller.selectedGender.value = selectedProfile.gender;
                    controller.neuroController.text = selectedProfile.neurodevelopmentalDisorder ?? "";
                  },
                ),
                const SizedBox(height: 15),
                SatuaTextFormFieldWidget(
                  title: 'Usia:',
                  controller: controller.ageController,
                ),
                const SizedBox(height: 15),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Bahasa:", style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                      const SizedBox(height: 8.0),
                      DropdownButtonFormField<String>(
                        value: controller.selectedLang.value.isNotEmpty ? controller.selectedLang.value : null,
                        onChanged: (String? newValue) {
                          controller.selectedLang.value = newValue ?? 'English';
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
                        items: ['English', 'Bahasa Indonesia', 'Bahasa Bali'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Obx(
                  () => Column(
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
                ),
                const SizedBox(height: 15),
                SatuaTextFormFieldWidget(
                  title: 'NDD (Diisi orang tua):',
                  controller: controller.neuroController,
                ),
                const SizedBox(height: 15),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tema Cerita:", style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                      const SizedBox(height: 8.0),
                      DropdownButtonFormField<String>(
                        value: controller.storyCategory.value.isNotEmpty ? controller.storyCategory.value : null,
                        onChanged: (String? newValue) {
                          controller.storyCategory.value = newValue!;
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
                        items: ["Dongeng", "Cerita Rakyat", "Fantasi", "Persahabatan", "Petualangan", "Komedi", "Tumbuh Dewasa", "Mitos", "Cerita Tradisional", "Sejarah", "Alam", "Fiksi Ilmiah (Sci-fi)"].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SatuaTextFormFieldWidget(
                  title: 'Cerita ini tentang:',
                  controller: controller.aboutController,
                ),
                const SizedBox(height: 15),
                SatuaTextFormFieldWidget(
                  title: 'Lokasinya ada di:',
                  controller: controller.placeController,
                ),
                const SizedBox(height: 15),
                SatuaTextFormFieldWidget(
                  title: 'Feeling dari cerita ini adalah:',
                  controller: controller.feelController,
                ),
                const SizedBox(height: 15),
                SatuaTextFormFieldWidget(
                  title: 'Pesan moral utama untuk anak adalah:',
                  controller: controller.primaryValController,
                ),
                const SizedBox(height: 15),
                SatuaTextFormFieldWidget(
                  title: 'Tambahkan karakter (opsional):',
                  controller: controller.additionalCharacterController,
                ),
                const SizedBox(height: 15),
                SatuaTextFormFieldWidget(
                  title: 'Detail tambahan untuk cerita (opsional)',
                  controller: controller.extraDetailsController,
                ),
                const SizedBox(height: 15),
                Obx(
                  () => SatuaTextFormFieldRandomizerWidget(
                    title: 'Randomizer, klik untuk menambahkan prompt random:',
                    controller: controller.randomPromptController,
                    childWidget: GestureDetector(
                      onTap: () async {
                        controller.generateRandomPrompt();
                      },
                      child: Container(
                        width: 58,
                        height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xFF8FDEBC)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: controller.isGeneratingRandomPrompt.value
                                ? const SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/images/randomizer.png',
                                    key: const ValueKey('icon'),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: controller.randomPromptController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              controller.randomPromptController.clear();
                            },
                            child: const Icon(Icons.clear),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 45),
                ElevatedButton(
                  onPressed: controller.goToResult,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFDE00),
                    textStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    'Buat Cerita!',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 40),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Text(
                      "Copyright © 2024 Satua. All Rights Reserved.",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Color(0xFF666666)),
                    ),
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
