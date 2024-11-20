import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
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
          'Koleksi Cerita',
          style: TextStyleManager.titleGreen(),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.stories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Semua Cerita",
                              style: TextStyleManager.title(),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              width: 140,
                              height: 50,
                              child: DropdownButtonFormField<String>(
                                value: controller.selectedSortOption.value.isNotEmpty ? controller.selectedSortOption.value : null,
                                onChanged: (String? newValue) {
                                  controller.selectedSortOption.value = newValue!;
                                  controller.sortStory();
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
                        const SizedBox(height: 15),
                        Obx(
                          () => Container(
                            width: Get.width,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: controller.tags.map((tag) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                    child: ChoiceChip(
                                      label: Text(tag),
                                      selected: controller.selectedTags.value == tag,
                                      onSelected: (bool isSelected) {
                                        if (isSelected) {
                                          controller.fetchFilteredStories(tag);
                                        } else {
                                          controller.fetchAllStories();
                                        }
                                      },
                                      labelStyle: TextStyleManager.mediumGray(
                                        fontSize: 12,
                                        color: controller.selectedTags.value == tag ? Colors.white : const Color(0xFF666666),
                                      ),
                                      backgroundColor: controller.selectedTags.value == tag ? const Color(0xFF00B567) : const Color(0xFFE8E8E8),
                                      selectedColor: const Color(0xFF00B567),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: const BorderSide(style: BorderStyle.none),
                                      ),
                                      showCheckmark: false,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Obx(
                          () => Column(
                            children: List.generate(
                              controller.allStory.length,
                              (index) {
                                final story = controller.allStory[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => const StoryListDetailView(), arguments: story);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                        // const SizedBox(height: 10.0),
                                        // Wrap(
                                        //   spacing: 8.0,
                                        //   children: story.category.map((category) => _buildBadge(category)).toList(),
                                        // ),
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
