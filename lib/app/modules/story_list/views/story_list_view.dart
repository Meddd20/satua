import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/model/story_model.dart';
import 'package:satua/app/modules/story_list/views/story_list_detail_view.dart';
import 'package:satua/app/routes/app_pages.dart';
import '../controllers/story_list_controller.dart';

class StoryListView extends GetView<StoryListController> {
  const StoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(width: 5),
            IconButton(onPressed: () => Get.offAllNamed(Routes.HOME), icon: const Icon(Icons.close)),
          ],
        ),
        title: Text(
          'Relive your stories',
          style: TextStyleManager.titleGreen(),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.stories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No story found'));
          } else {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          child: Text(
                            "Story Gallery",
                            style: TextStyleManager.title(),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          children: List.generate(
                            snapshot.data!.length,
                            (index) {
                              final story = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => const StoryListDetailView(), arguments: story);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8.0), // Add vertical margin for spacing
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                                    children: [
                                      Text(
                                        story.title,
                                        style: TextStyleManager.mediumGray(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        story.body,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyleManager.regular12(),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Wrap(
                                        spacing: 8.0,
                                        children: story.category.map((category) => _buildBadge(category)).toList(),
                                      ),
                                      const SizedBox(height: 15.0),
                                      Text(
                                        DateFormat('d MMMM yyyy').format(DateTime.parse(story.createTime)),
                                        style: TextStyleManager.mediumGray12(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildBadge(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[200],
      ),
      child: Text(
        category,
        style: TextStyle(fontSize: 10.0, color: Colors.grey[600]),
      ),
    );
  }
}
