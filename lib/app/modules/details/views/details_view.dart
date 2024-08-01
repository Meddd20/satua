import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/modules/details/views/satua_text_form_field.dart';

import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Imagine your story',
          style: TextStyleManager.titleGreen(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SatuaTextFormFieldWidget(
                        title: 'My name is:',
                        controller: controller.nameController,
                      ),
                      const SizedBox(height: 15),
                      SatuaTextFormFieldWidget(
                        title: 'Age:',
                        controller: controller.ageController,
                      ),
                      const SizedBox(height: 15),
                      SatuaTextFormFieldWidget(
                        title: 'NDD (Filled by Parents):',
                        controller: controller.neuroController,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Language:", style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
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
                      const SizedBox(height: 15),
                      SatuaTextFormFieldWidget(
                        title: 'This story is about:',
                        controller: controller.aboutController,
                      ),
                      const SizedBox(height: 15),
                      SatuaTextFormFieldWidget(
                        title: 'The story should take place in:',
                        controller: controller.placeController,
                      ),
                      const SizedBox(height: 15),
                      SatuaTextFormFieldWidget(
                        title: 'The story should feel:',
                        controller: controller.feelController,
                      ),
                      const SizedBox(height: 15),
                      SatuaTextFormFieldWidget(
                        title: 'I want to learn about:',
                        controller: controller.primaryValController,
                      ),
                      const SizedBox(height: 15),
                      SatuaTextFormFieldWidget(
                        title: 'Please also add in:',
                        controller: controller.extraController,
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
                          'Generate Story!',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 70),
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
            ],
          ),
        ),
      ),
    );
  }
}
