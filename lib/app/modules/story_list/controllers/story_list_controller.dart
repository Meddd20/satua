import 'package:get/get.dart';
import 'package:satua/app/model/story_model.dart';
import 'package:satua/app/services/story_service.dart';

class StoryListController extends GetxController {
  final StoryService storyService = StoryService();
  late final Future<List<Story>> stories;

  @override
  void onInit() {
    stories = fetchAllStories();
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

  Future<List<Story>> fetchAllStories() {
    return storyService.getAllStories();
  }
}
