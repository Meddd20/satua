import 'package:flutter/cupertino.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/model/profile_model.dart';
import 'package:satua/app/model/story_model.dart';
import 'package:satua/app/routes/app_pages.dart';
import 'package:satua/app/services/profile_service.dart';
import 'package:satua/app/services/story_service.dart';

class DetailsController extends GetxController {
  final gemini = Gemini.instance;
  final ProfileService profileService = ProfileService();
  final StoryService storyService = StoryService();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final aboutController = TextEditingController();
  final neuroController = TextEditingController();
  final placeController = TextEditingController();
  final feelController = TextEditingController();
  final primaryValController = TextEditingController();
  final additionalCharacterController = TextEditingController();
  final extraDetailsController = TextEditingController();
  final randomPromptController = TextEditingController();
  final RxString selectedGender = ''.obs;
  final RxString selectedLang = ''.obs;
  final RxList<Profile> allProfile = <Profile>[].obs;
  final RxBool isEditedStory = false.obs;
  final RxString? editedStoryId = ''.obs;
  final RxString storyCategory = ''.obs;
  RxBool isGeneratingRandomPrompt = false.obs;

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
      storyCategory.value = arguments.category;
      randomPromptController.text = arguments.randomPrompt ?? "";
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
    if (storyCategory.value.isEmpty) {
      showToast('Kategori cerita belum dipilih.');
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
      'category': storyCategory.value.trim(),
      'about': aboutController.text.trim(),
      'setting': placeController.text.trim(),
      'feel': feelController.text.trim(),
      'primaryValues': primaryValController.text.trim(),
      'neuroCondition': neuroController.text.isNotEmpty ? neuroController.text.trim() : '',
      'additionalCharacter': additionalCharacterController.text.isNotEmpty ? additionalCharacterController.text.trim() : '',
      'extraDetails': extraDetailsController.text.isNotEmpty ? extraDetailsController.text.trim() : '',
      'isEditedStory': isEditedStory.value.toString(),
      'randomPrompt': randomPromptController.text.isNotEmpty ? randomPromptController.text.trim() : '',
    };

    Get.toNamed(Routes.RESULT, parameters: parameters);
  }

  String generatePrompt() {
    final String prompt = '''
    Create a children's story in the `${storyCategory.value}` genre, starting with the title on the first line. The story should feature a child named `${nameController.text}`, aged `${ageController.text}`, and written in `${selectedLang.value}`. The story revolves around `${aboutController.text}`, ensuring appropriate pronouns for their gender, which is `${selectedGender.value}`. The setting should take place in `${placeController.text}`, and the tone should feel `${feelController.text}`. The story must highlight `${primaryValController.text}` as primary values to help the child learn important lessons. 

    Incorporate additional details such as `${extraDetailsController.text}` (if provided) and additional characters like `${additionalCharacterController.text}` (if provided). Ensure the story accounts for the child’s special condition: `${neuroController.text}`. Use the random element `${randomPromptController.text}` (if provided) to add uniqueness. The story should consist of at least three paragraphs, formatted with the title in the first line, followed by the body in a single line with paragraphs separated by a newline (`\n`).  Conclude with three reflective questions for the child to ponder. Format the story as markdown using the following structure:   

    <title>Title of the Story</title>
    <body>The story body with paragraphs separated by newlines (\n).</body>
    <questions>
    1. Reflective question 1
    2. Reflective question 2
    3. Reflective question 3
    </questions>
    <category>Story genre</category>

    Always adhere strictly to this markdown format. Do not miss any details or formatting. The output must be clear, consistent, and error-free. Let’s ensure this works perfectly!

    ''';
    // final String thePrompt =
    //     '''Make me a children's story with the ${storyCategory.value} genre with the title in the first line. The name of the child is ${nameController.text}, aged ${ageController.text} with $selectedLang as the language. The story should be about ${aboutController.text}. Make sure to use the right pronouns as the gender is $selectedGender. The story is to take place in ${placeController.text}, and the story should feel ${feelController.text}. The story should have ${primaryValController.text} as the primary values to make the child learn. Add another detail like "${extraDetailsController.text}" (ignore if left blank) and additinal characters like "${additionalCharacterController.text}" (ignore if left blank). Add 3 reflective questions at the end for the child to reflect on the story. Special condition of the child includes ${neuroController.text}. Ensure the story is suitable for the child’s condition. Use this random element ${randomPromptController.text} (ignore if left blank)to make the story unique. The story should be as long as 3 paragraph or more. The story should be formatted with the title on the first line, followed by the body of the story in only one line, with paragraphs separated by a single newline or slash n. Conclude the story with three reflective questions for the child. Format the story as an markdown with <title></title> <body></body <questions></questions> <category></category>. ALWAYS GENERATE THE STORY WITH FORMATTED MARKDOWN GIVEN!! DONT SCREW UP ANYTHING, IF YOU DO I'LL GET FIRED AND I WILL SUE YOU FOR THAT. SO LETS WORK TOGETHER. USE THE RIGHT MARKDOWN FORMAT''';
    return prompt;
  }

  Future<void> fetchAllProfile() async {
    List<Profile> fetchedProfileList = await profileService.getAllProfiles();
    allProfile.assignAll(fetchedProfileList);
  }

  Future<void> fetchLastCreatedStory() async {
    Story? fetchedStoryList = await storyService.getLastCreatedStory();
    if (fetchedStoryList != null) {
      nameController.text = fetchedStoryList.name;
      ageController.text = fetchedStoryList.age;
      aboutController.text = fetchedStoryList.storyAbout;
      neuroController.text = fetchedStoryList.neurodevelopmentalDisorder ?? "";
      placeController.text = fetchedStoryList.storySetting;
      feelController.text = fetchedStoryList.storyFeel;
      primaryValController.text = fetchedStoryList.primaryValues;
      additionalCharacterController.text = fetchedStoryList.additionalCharacter ?? "";
      extraDetailsController.text = fetchedStoryList.extraDetails ?? "";
      randomPromptController.text = fetchedStoryList.randomPrompt ?? "";
      selectedGender.value = fetchedStoryList.gender;
      selectedLang.value = fetchedStoryList.language;
      storyCategory.value = fetchedStoryList.category;
    }
  }

  Future<void> generateRandomPrompt() async {
    try {
      isGeneratingRandomPrompt.value = true;
      const String prompt = "make me a children's book-friendly prompt to add a randomizer to the story. keep it short but exciting. use no explanation, the format is just '[random prompt]'. Don't provide any fill in the blank, provide a full sentence";

      String content = '';
      await gemini.text(prompt).then((value) {
        content = '${value?.content?.parts?.first.text}';
      });

      if (content != "" || content.isNotEmpty) {
        randomPromptController.text = content;
        isGeneratingRandomPrompt.value = false;
      }
    } catch (e) {
      if (e is GeminiException) {
        showToast(e.message.toString());
      }
    }
  }
}
