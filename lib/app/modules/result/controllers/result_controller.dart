import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/routes/app_pages.dart';
import 'package:satua/app/services/story_service.dart';

class ResultController extends GetxController {
  final gemini = Gemini.instance;
  final RxString result = ''.obs;
  final RxString title = ''.obs;
  final RxString body = ''.obs;
  final RxString categories = ''.obs;
  final RxString questions = ''.obs;
  final RxBool isRead = false.obs;
  bool load = true;
  final RxString userPrompt = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    userPrompt.value = Get.parameters['userPrompt'] ?? '';
    generateStory(userPrompt.value);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToStoryList() {
    Get.toNamed(Routes.STORY_LIST, parameters: {});
  }

  Future<String> generateStory(String userPrompt) async {
    try {
      String content = '';
      final response = await gemini.text(userPrompt).then((value) {
        content = '${value?.content?.parts?.first.text}';
      }).catchError((e) => showToast(e.toString()));

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

      if (content != '' && body.value == '') {
        showCustomToastWithRetry(userPrompt);
      }

      return content;
    } catch (e) {
      if (e is GeminiException) {
        showToast(e.message.toString());
      }
      return '';
    }
  }

  Future<void> saveStory() async {
    List<String> questionsList = questions.value.split(',');
    List<String> categoriesList = categories.value.split(',');
    StoryService().saveNewStory(title.value, body.value, questionsList, categoriesList, isRead.value);
  }

  void showCustomToastWithRetry(String userPrompt) {
    Fluttertoast.showToast(
      msg: "The story format is invalid. Retry?",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    Fluttertoast.showToast(
      msg: "Retry",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    Future.delayed(Duration(seconds: 2), () {
      Fluttertoast.showToast(
        msg: "Retry",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
        webShowClose: true,
        webPosition: "center",
        timeInSecForIosWeb: 1,
        webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
      ).then((value) => generateStory(userPrompt));
    });
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
