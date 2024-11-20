import 'package:get/get.dart';
import 'package:satua/app/model/story_model.dart';
import 'package:satua/app/services/story_service.dart';

class StoryListController extends GetxController {
  final StoryService storyService = StoryService();
  late final Future<List<Story>> stories;
  RxString selectedSortOption = ''.obs;
  final RxList<Story> allStory = <Story>[].obs;
  RxString selectedTags = "".obs;
  List<String> tags = [
    "Dongeng",
    "Cerita Rakyat",
    "Fantasi",
    "Persahabatan",
    "Petualangan",
    "Komedi",
    "Tumbuh Dewasa",
    "Mitos",
    "Cerita Tradisional",
    "Sejarah",
    "Alam",
    "Fiksi Ilmiah (Sci-fi)",
  ];

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

  Future<List<Story>> fetchAllStories() async {
    selectedTags.value = "";
    List<Story> fetchedStoryList = await storyService.getAllStories();
    allStory.addAll(fetchedStoryList);
    return fetchedStoryList;
  }

  Future<void> fetchFilteredStories(String filterTag) async {
    selectedTags.value = filterTag;
    List<Story>? fetchedStoryList = await storyService.getStoryByTags(filterTag);
    allStory.clear();
    if (fetchedStoryList!.isNotEmpty) {
      allStory.addAll(fetchedStoryList);
    }
  }

  void sortStory() {
    if (selectedSortOption.value == 'Sort by A from Z') {
      allStory.sort((a, b) => a.title.compareTo(b.title));
    } else if (selectedSortOption.value == 'Sort by Z from A') {
      allStory.sort((a, b) => b.title.compareTo(a.title));
    } else if (selectedSortOption.value == 'Newest') {
      allStory.sort((a, b) => b.createTime.compareTo(a.createTime));
    } else if (selectedSortOption.value == 'Oldest') {
      allStory.sort((a, b) => a.createTime.compareTo(b.createTime));
    }
    allStory.refresh();
  }
}
