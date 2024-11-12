import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/model/profile_model.dart';
import 'package:satua/app/model/story_model.dart';
import 'package:satua/app/routes/app_pages.dart';
import 'package:satua/app/services/profile_service.dart';

class DetailsController extends GetxController {
  final ProfileService profileService = ProfileService();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final aboutController = TextEditingController();
  final neuroController = TextEditingController();
  final placeController = TextEditingController();
  final feelController = TextEditingController();
  final primaryValController = TextEditingController();
  final additionalCharacterController = TextEditingController();
  final extraDetailsController = TextEditingController();
  final RxString selectedGender = ''.obs;
  final RxString selectedLang = ''.obs;
  final RxList<Profile> allProfile = <Profile>[].obs;
  final RxBool isEditedStory = false.obs;
  final RxString? editedStoryId = ''.obs;

  @override
  void onInit() {
    final arguments = Get.arguments;
    if (arguments is Story) {
      editedStoryId?.value = arguments.id ?? "";
      nameController.text = arguments.name;
      ageController.text = arguments.age;
      selectedLang.value = arguments.language;
      selectedGender.value = arguments.gender;
      neuroController.text = arguments.neurodevelopmentalDisorder ?? "";
      aboutController.text = arguments.storyAbout;
      placeController.text = arguments.storySetting;
      feelController.text = arguments.storyFeel;
      primaryValController.text = arguments.primaryValues;
      additionalCharacterController.text = arguments.additionalCharacter ?? "";
      extraDetailsController.text = arguments.extraDetails ?? "";
      isEditedStory.value = true;
    }
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

  void goToResult() {
    if (nameController.text.isEmpty) {
      showToast('Nama tidak boleh kosong, harap diisi.');
      return;
    }
    if (ageController.text.isEmpty) {
      showToast('Usia harus diisi.');
      return;
    }
    if (selectedLang.value.isEmpty) {
      showToast('Bahasa belum dipilih.');
      return;
    }
    if (selectedGender.value.isEmpty) {
      showToast('Jenis kelamin harus dipilih.');
      return;
    }
    if (aboutController.text.isEmpty) {
      showToast('Jelaskan topik cerita Anda.');
      return;
    }
    if (placeController.text.isEmpty) {
      showToast('Harap tentukan latar cerita.');
      return;
    }
    if (feelController.text.isEmpty) {
      showToast('Sampaikan bagaimana perasaan yang ingin ditimbulkan cerita ini.');
      return;
    }
    if (primaryValController.text.isEmpty) {
      showToast('Tuliskan nilai utama yang ingin disampaikan dalam cerita.');
      return;
    }

    Map<String, String> parameters = {
      'userPrompt': generatePrompt(),
      'storyId': editedStoryId?.value.trim() ?? "",
      'name': nameController.text.trim(),
      'age': ageController.text.trim(),
      'language': selectedLang.value.trim(),
      'gender': selectedGender.value.trim(),
      'about': aboutController.text.trim(),
      'setting': placeController.text.trim(),
      'feel': feelController.text.trim(),
      'primaryValues': primaryValController.text.trim(),
      'neuroCondition': neuroController.text.isNotEmpty ? neuroController.text.trim() : '',
      'additionalCharacter': additionalCharacterController.text.isNotEmpty ? additionalCharacterController.text.trim() : '',
      'extraDetails': extraDetailsController.text.isNotEmpty ? extraDetailsController.text.trim() : '',
      'isEditedStory': isEditedStory.value.toString(),
    };

    Get.toNamed(Routes.RESULT, parameters: parameters);
  }

  String generatePrompt() {
    // final String thePrompt =
    //     'Make me children story with the title in first line. The name of the child is ${nameController.text}, aged ${ageController.text} with $selectedLang as the language. The story should be about ${aboutController.text}. Make sure to use the right pronouns as the gender is $selectedGender . The story is to take place in ${placeController.text}, the story should feel ${feelController.text}. the story should have ${primaryValController.text} as the primary values to make child learn. Add another detail like "${extraController.text}" (ignore if left blank). Add 3 reflective question at the end for the kid to reflect on the story. Special condition of the child includes ${neuroController.text}. Please ensure the story is appropriate to the childs condition.';
    final String thePrompt =
        '''Make me a children's story with the title in the first line. The name of the child is ${nameController.text}, aged ${ageController.text} with $selectedLang as the language. The story should be about ${aboutController.text}. Make sure to use the right pronouns as the gender is $selectedGender. The story is to take place in ${placeController.text}, and the story should feel ${feelController.text}. The story should have ${primaryValController.text} as the primary values to make the child learn. Add another detail like "${extraDetailsController.text}" (ignore if left blank) and additinal characters like "${additionalCharacterController.text}" (ignore if left blank). Add 3 reflective questions at the end for the child to reflect on the story. Special condition of the child includes ${neuroController.text}. Ensure the story is suitable for the child’s condition. The story should be as long as 3 paragraph or more. The story should be formatted with the title on the first line, followed by the body of the story in only one line, with paragraphs separated by a single newline or slash n. Conclude the story with three reflective questions for the child. Format the story as an markdown with <title></title> <body></body <questions></questions> <category></category>. ALWAYS GENERATE THE STORY WITH FORMATTED MARKDOWN GIVEN!! DONT SCREW UP ANYTHING, IF YOU DO I'LL GET FIRED AND I WILL SUE YOU FOR THAT. SO LETS WORK TOGETHER. USE THE RIGHT MARKDOWN FORMAT''';
    return thePrompt;
  }

  Future<void> fetchAllProfile() async {
    List<Profile> fetchedProfileList = await profileService.getAllProfiles();
    allProfile.assignAll(fetchedProfileList);
  }
}
