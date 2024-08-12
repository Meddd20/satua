import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/routes/app_pages.dart';
import '../controllers/tracker_controller.dart';

class TrackerView extends GetView<TrackerController> {
  const TrackerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Relive your stories',
          style: TextStyleManager.titleGreen(),
        ),
        leading: Row(
          children: [
            const SizedBox(width: 5),
            IconButton(onPressed: () => Get.offAllNamed(Routes.HOME), icon: const Icon(Icons.close)),
          ],
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getReadProgress(),
        builder: (context, snapshot) {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 83),
                      const Text(
                        'Stories Read',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 96.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 160.0,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.countReadToday().toString(),
                                    style: const TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Stories read today',
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 160.0,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.countReadThisWeek().toString(),
                                    style: const TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Stories read this week.",
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 39),
                      const Text(
                        "Monthly Progress",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.getNonEmptyReadStories().length,
                    itemBuilder: (context, index) {
                      final entry = controller.getNonEmptyReadStories()[index];
                      final year = entry.key.split('-')[0];
                      final month = entry.key.split('-')[1];
                      final monthName = DateFormat('MMMM').format(DateTime(int.parse(year), int.parse(month)));
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8, right: 20, left: 20),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                monthName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                entry.value.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
                const SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}
