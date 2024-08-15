import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/model/story_model.dart';
import 'package:satua/app/routes/app_pages.dart';
import 'package:satua/app/services/story_service.dart';

class ResultController extends GetxController {
  final gemini = Gemini.instance;
  final storyService = StoryService();
  final RxString result = ''.obs;
  final RxString title = ''.obs;
  final RxString body = ''.obs;
  final RxString categories = ''.obs;
  final RxString questions = ''.obs;
  final RxBool isRead = false.obs;
  bool load = true;
  final RxString userPrompt = ''.obs;
  final RxBool isEdited = false.obs;
  RxList<String> questionsList = <String>[].obs;
  RxList<String> categoriesList = <String>[].obs;
  final Rx<Story?> detailsQuery = Rx<Story?>(null);

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    final params = Get.parameters;
    userPrompt.value = params['userPrompt'] ?? '';
    isEdited.value = params['isEditedStory'] == 'true';

    generateStory(userPrompt.value).then((_) {
      detailsQuery.value = Story(
        id: params['storyId'] ?? '',
        title: title.value.trim(),
        body: body.value.trim(),
        reflectiveQuestions: questionsList,
        category: categoriesList,
        name: params['name'] ?? '',
        age: params['age'] ?? '',
        language: params['language'] ?? '',
        gender: params['gender'] ?? '',
        storyAbout: params['about'] ?? '',
        storySetting: params['setting'] ?? '',
        storyFeel: params['feel'] ?? '',
        primaryValues: params['primaryValues'] ?? '',
        neurodevelopmentalDisorder: params['neuroCondition'] ?? '',
        additionalCharacter: params['additionalCharacter'] ?? '',
        extraDetails: params['extraDetails'] ?? '',
        isRead: isRead.value,
        readTime: DateTime.now().toString(),
        createTime: DateTime.now().toString(),
        updateTime: DateTime.now().toString(),
      );
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToStoryList() {
    Get.toNamed(Routes.STORY_LIST, parameters: {});
  }

  Future<void> generateStory(String userPrompt) async {
    try {
      String content = '';
      await gemini.text(userPrompt).then((value) {
        content = '${value?.content?.parts?.first.text}';
      });

      final titleExp = RegExp(r'<title>(.*?)<\/title>', dotAll: true);
      final titleMatch = titleExp.firstMatch(content);
      if (titleMatch != null) {
        title.value = titleMatch.group(1)!.toString().trim();
      }

      final bodyExp = RegExp(r'<body>(.*?)<\/body>', dotAll: true);
      final bodyMatch = bodyExp.firstMatch(content);
      if (bodyMatch != null) {
        body.value = bodyMatch.group(1)!.toString().trim();
      }

      final questionsExp = RegExp(r'<questions>(.*?)<\/questions>', dotAll: true);
      final questionsMatch = questionsExp.firstMatch(content);
      if (questionsMatch != null) {
        questions.value = questionsMatch.group(1)!.toString().trim();
      }

      final categoryExp = RegExp(r'<category>(.*?)<\/category>', dotAll: true);
      final categoryMatch = categoryExp.firstMatch(content);
      if (categoryMatch != null) {
        categories.value = categoryMatch.group(1)!.toString().trim();
      }

      if (content != '' && body.value == '' && questions.value == '') {
        showCustomToastWithRetry(userPrompt);
      }

      questionsList.value = questions.value.split(',').map((q) => q.trim()).toList();
      categoriesList.value = categories.value.split(',').map((c) => c.trim()).toList();
    } catch (e) {
      if (e is GeminiException) {
        showToast(e.message.toString());
      }
    }
  }

  Future<void> saveStory() async {
    if (detailsQuery.value == null) {
      showToast('Story details are not available.');
      return;
    }

    await storyService.saveNewStory(
      title.value.trim(),
      body.value.trim(),
      detailsQuery.value!.reflectiveQuestions,
      detailsQuery.value!.category,
      detailsQuery.value!.isRead,
      detailsQuery.value!.name,
      detailsQuery.value!.age,
      detailsQuery.value!.language,
      detailsQuery.value!.gender,
      detailsQuery.value!.neurodevelopmentalDisorder,
      detailsQuery.value!.storyAbout,
      detailsQuery.value!.storySetting,
      detailsQuery.value!.storyFeel,
      detailsQuery.value!.primaryValues,
      detailsQuery.value!.additionalCharacter,
      detailsQuery.value!.extraDetails,
    );
  }

  Future<void> updateStory() async {
    if (detailsQuery.value == null) {
      showToast('Story details are not available.');
      return;
    }

    storyService.updateStory(
      detailsQuery.value!.id ?? '',
      title.value.trim(),
      body.value.trim(),
      detailsQuery.value!.reflectiveQuestions,
      detailsQuery.value!.category,
      detailsQuery.value!.isRead,
      detailsQuery.value!.name,
      detailsQuery.value!.age,
      detailsQuery.value!.language,
      detailsQuery.value!.gender,
      detailsQuery.value!.neurodevelopmentalDisorder,
      detailsQuery.value!.storyAbout,
      detailsQuery.value!.storySetting,
      detailsQuery.value!.storyFeel,
      detailsQuery.value!.primaryValues,
      detailsQuery.value!.additionalCharacter,
      detailsQuery.value!.extraDetails,
    );
  }

  void showCustomToastWithRetry(String userPrompt) {
    Fluttertoast.showToast(
      msg: "The story format is invalid. Retrying...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    Future.delayed(Duration(seconds: 2), () {
      generateStory(userPrompt);
    });
  }
}
