import 'package:get/get.dart';
import 'package:satua/app/model/story_model.dart';
import 'package:satua/app/routes/app_pages.dart';
import 'package:satua/app/services/story_service.dart';

class StoryListDetailController extends GetxController {
  final StoryService storyService = StoryService();
  late final Story story;
  RxBool isRead = false.obs;

  @override
  void onInit() {
    story = Get.arguments as Story;
    isRead.value = story.isRead;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> deleteStory(String storyId) async {
    await storyService.deleteStory(storyId);
    Get.offAllNamed(Routes.STORY_LIST);
  }

  Future<void> isStoryRead(String storyId) async {
    await storyService.updateStoryReadStatus(storyId, isRead.value);
  }
}
