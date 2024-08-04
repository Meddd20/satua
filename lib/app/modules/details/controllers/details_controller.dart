import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/routes/app_pages.dart';
import 'package:satua/app/services/auth_service.dart';

class DetailsController extends GetxController {
  final Map<String, dynamic> args = Get.parameters;
  final title = ''.obs;
  final RxString selectedGender = ''.obs;
  final RxString selectedLang = ''.obs;
  Future<Map<String, String>?>? userData;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final aboutController = TextEditingController();
  final neuroController = TextEditingController();

  final placeController = TextEditingController();
  final feelController = TextEditingController();
  final primaryValController = TextEditingController();
  final extraController = TextEditingController();

  @override
  void onInit() {
    _fetchUserData();
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

  Future<void> _fetchUserData() async {
    userData = AuthService().getUserEmailAndUsername();
    final data = await userData;

    if (data != null) {
      nameController.text = data['username'] ?? '';
    }
  }

  void goToResult() {
    if (nameController.text.isEmpty) {
      showToast('Name cannot be empty');
      return;
    }
    if (ageController.text.isEmpty) {
      showToast('Age cannot be empty');
      return;
    }
    if (selectedGender.value.isEmpty) {
      showToast('Gender cannot be empty');
      return;
    }
    if (selectedLang.value.isEmpty) {
      showToast('Language cannot be empty');
      return;
    }
    if (aboutController.text.isEmpty) {
      showToast('Fill out what your story will be about');
      return;
    }
    if (placeController.text.isEmpty) {
      showToast('Specify the setting for the story');
      return;
    }
    if (feelController.text.isEmpty) {
      showToast('Describe how the story should feel');
      return;
    }
    if (primaryValController.text.isEmpty) {
      showToast('Fill out the primary values the story will convey');
      return;
    }

    Get.toNamed(Routes.RESULT, parameters: {'userPrompt': generatePrompt()});
  }

  String generatePrompt() {
    // final String thePrompt =
    //     'Make me children story with the title in first line. The name of the child is ${nameController.text}, aged ${ageController.text} with $selectedLang as the language. The story should be about ${aboutController.text}. Make sure to use the right pronouns as the gender is $selectedGender . The story is to take place in ${placeController.text}, the story should feel ${feelController.text}. the story should have ${primaryValController.text} as the primary values to make child learn. Add another detail like "${extraController.text}" (ignore if left blank). Add 3 reflective question at the end for the kid to reflect on the story. Special condition of the child includes ${neuroController.text}. Please ensure the story is appropriate to the childs condition.';
    final String thePrompt =
        '''Make me a children's story with the title in the first line. The name of the child is ${nameController.text}, aged ${ageController.text} with $selectedLang as the language. The story should be about ${aboutController.text}. Make sure to use the right pronouns as the gender is $selectedGender. The story is to take place in ${placeController.text}, and the story should feel ${feelController.text}. The story should have ${primaryValController.text} as the primary values to make the child learn. Add another detail like "${extraController.text}" (ignore if left blank). Add 3 reflective questions at the end for the child to reflect on the story. Special condition of the child includes ${neuroController.text}. Ensure the story is suitable for the child’s condition. The story should be as long as 3 paragraph or more. The story should be formatted with the title on the first line, followed by the body of the story in only one line, with paragraphs separated by a single newline or slash n. Conclude the story with three reflective questions for the child. Format the story as an markdown with <title></title> <body></body <questions></questions> <category></category>. ALWAYS GENERATE THE STORY WITH FORMATTED MARKDOWN GIVEN!! DONT SCREW UP ANYTHING, IF YOU DO I'LL GET FIRED AND I WILL SUE YOU FOR THAT. SO LETS WORK TOGETHER''';
    return thePrompt;
  }
}
