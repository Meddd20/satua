import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:satua/app/core/theme_manager/assets_manager.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';

import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              padding: const EdgeInsets.only(left: 25),
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close),
            ),
            title: Text(
              'Imagine your story',
              style: TextStyleManager.titleGreen(),
            ),
          ),
          body: controller.result.value != ''
              ? SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(controller.title.value),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(controller.result.value),
                      const SizedBox(
                        height: 45,
                      ),
                      ElevatedButton(
                        onPressed: controller.goToStoryList,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFFDE00), // Your background color
                          textStyle: const TextStyle(
                              color: Color.fromARGB(
                                  255, 255, 255, 255)), // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), // Border radius
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 32.0),
                          // Makes the button as wide as the parent container:
                          minimumSize: const Size.fromHeight(
                              50), // Adjust height if needed
                        ),
                        child: const Text(
                          'Save Story!',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                   
                )
              : Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 150,
                              height: 150,
                              child: Image.asset(
                                  '${AssetManager.imagePath}/awan-hijau.png')),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Hang on a second!',
                            style: TextStyleManager.titleGreen(),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 250,
                            child: Text(
                              'Satua is now generating your bed\ntime story...',
                              textAlign: TextAlign.center,
                              style: TextStyleManager.medium12(fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            height: 200,
                          )
                        ],
                      )
                          .animate(onPlay: (controller) => controller.repeat())
                          .effect(duration: 3000.ms)
                          .effect(delay: 750.ms, duration: 1500.ms)
                          .fadeIn(curve: Curves.easeOutCirc)
                          .untint(color: Colors.white)
                          .blurXY(begin: 16)
                          .scaleXY(begin: 1.5),
                    ),
                  ),
                ),
             
        ));
  }
}