import 'package:get/get.dart';

import 'package:satua/app/modules/story_list/controllers/story_list_detail_controller.dart';

import '../controllers/story_list_controller.dart';

class StoryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoryListDetailController>(
      () => StoryListDetailController(),
    );
    Get.lazyPut<StoryListController>(
      () => StoryListController(),
    );
  }
}
