import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/modules/story_list/controllers/story_list_detail_controller.dart';
import 'package:satua/app/routes/app_pages.dart';

class StoryListDetailView extends GetView<StoryListDetailController> {
  const StoryListDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(StoryListDetailController());
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(width: 5),
            IconButton(
              onPressed: () => Get.offAllNamed(Routes.STORY_LIST),
              icon: const Icon(Icons.close),
              color: const Color(0xFFBDBDBD),
            ),
          ],
        ),
        title: Text(
          'Imagine your stories',
          style: TextStyleManager.titleGreen(),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (String value) {
              if (value == 'Edit') {
                Get.toNamed(Routes.DETAILS, arguments: controller.story);
              } else if (value == 'Delete') {
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
                            "Delete Story?",
                            style: TextStyleManager.titleGreen(fontSize: 24),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Delete story can never be read nor recover again. Are you sure you want to delete this story?",
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
                            'Cancel',
                            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => controller.deleteStory(controller.story.id!),
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
                            'Delete Story',
                            style: TextStyle(color: Color(0xFFBDBDBD), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (value == 'Share') {
                copyStoryToClipboard();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'Delete',
                  child: Text('Delete'),
                ),
                const PopupMenuItem(
                  value: 'Share',
                  child: Text('Share as text'),
                ),
              ];
            },
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFFBDBDBD),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
          child: Column(
            children: [
              Container(
                width: Get.width,
                child: Text(
                  controller.story.title,
                  style: TextStyleManager.title(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                controller.story.body,
                style: TextStyleManager.regular12(fontSize: 14),
              ),
              const SizedBox(height: 30),
              Container(
                width: Get.width,
                child: Text(
                  "Reflective Questions:",
                  style: TextStyleManager.medium12(fontSize: 14, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 5),
              for (var questions in controller.story.reflectiveQuestions) ...[
                Container(
                  width: Get.width,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          questions.trim(),
                          style: TextStyleManager.regular12(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: controller.isRead.value,
                      onChanged: (isStoryRead) {
                        controller.isRead.value = isStoryRead!;
                        controller.isStoryRead(controller.story.id!);
                      },
                      activeColor: Colors.black,
                    ),
                    Text(
                      "Sudah selesai membaca",
                      style: TextStyleManager.regular12(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
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
    );
  }

  void copyStoryToClipboard() {
    final String storyContent = '''
      ${controller.story.title}

      ${controller.story.body}

      Reflective Questions:
      ${controller.story.reflectiveQuestions.join('\n')}
    ''';

    Clipboard.setData(ClipboardData(text: storyContent)).then((_) {
      showToast('Story copied to clipboard!');
    });
  }
}
