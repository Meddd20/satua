import 'package:get/get.dart';
import 'package:satua/app/model/story_model.dart';
import 'package:satua/app/services/story_service.dart';

class TrackerController extends GetxController {
  final StoryService storyService = StoryService();
  List<Story> stories = [];

  @override
  void onInit() async {
    super.onInit();
    getReadProgress();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getReadProgress() async {
    stories = await storyService.getAllStories();
  }

  int countReadToday() {
    final now = DateTime.now().toLocal();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1)).subtract(const Duration(microseconds: 1));

    return stories.where((story) {
      if (story.isRead == true && story.readTime != null) {
        final readDate = DateTime.parse(story.readTime!).toLocal();
        return readDate.isAfter(todayStart) && readDate.isBefore(todayEnd);
      }
      return false;
    }).length;
  }

  int countReadThisWeek() {
    final now = DateTime.now().toLocal();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return stories.where((story) => story.isRead == true && story.readTime != null && _isWithinWeek(DateTime.parse(story.readTime!), startOfWeek)).length;
  }

  Map<String, int> getReadStoriesPerMonth() {
    final readStoriesByMonth = <String, int>{};
    for (var story in stories) {
      if (story.isRead && story.readTime != null) {
        final readDate = DateTime.parse(story.readTime!);
        final yearMonth = '${readDate.year}-${readDate.month.toString().padLeft(2, '0')}';
        readStoriesByMonth.update(
          yearMonth,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
    }
    return readStoriesByMonth;
  }

  List<MapEntry<String, int>> getNonEmptyReadStories() {
    final readStoriesByMonth = getReadStoriesPerMonth();
    return readStoriesByMonth.entries.where((entry) => entry.value > 0).toList();
  }

  bool _isWithinWeek(DateTime date, DateTime startOfWeek) {
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) && date.isBefore(endOfWeek.add(Duration(days: 1)));
  }

  bool _isInMonth(DateTime date, int year, int month) {
    return date.year == year && date.month == month;
  }
}
