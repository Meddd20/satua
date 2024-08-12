import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/model/profile_model.dart';
import 'package:satua/app/routes/app_pages.dart';
import 'package:satua/app/services/profile_service.dart';

class ProfileFormController extends GetxController {
  final ProfileService profileService = ProfileService();
  final childsName = TextEditingController();
  final neurodevelopmentalDisorder = TextEditingController();
  RxBool isEditMode = false.obs;
  Profile? detailProfile;

  Rx<int?> age = Rx<int?>(null);
  final RxString selectedGender = ''.obs;

  @override
  void onInit() {
    final arguments = Get.arguments;
    if (arguments is Profile) {
      detailProfile = arguments;
      isEditMode.value = true;
      childsName.text = detailProfile!.childsName;
      setBirthDate(detailProfile!.birthDate);
      age.value = detailProfile!.age;
      selectedGender.value = detailProfile!.gender;
      neurodevelopmentalDisorder.text = detailProfile?.neurodevelopmentalDisorder ?? "";
    } else {
      isEditMode.value = false;
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

  Rx<DateTime?> birthDate = Rx<DateTime?>(null);
  DateTime? get getBirthDate => birthDate.value;

  void setBirthDate(DateTime? value) {
    birthDate.value = value;

    if (birthDate.value != null) {
      final today = DateTime.now();
      int years = today.year - birthDate.value!.year;

      if (today.month < birthDate.value!.month || (today.month == birthDate.value!.month && today.day < birthDate.value!.day)) {
        years--;
      }

      age.value = years;
    }
  }

  Future<void> createNewProfile() async {
    if (childsName.text.isEmpty) {
      showToast("Child's name cannot be empty");
      return;
    }

    if (getBirthDate == null) {
      showToast("Child's birth date cannot be empty");
      return;
    }

    if (age.value == null) {
      showToast("Child's age cannot be empty");
      return;
    }

    if (selectedGender.value.isEmpty) {
      showToast("Child's gender cannot be empty");
      return;
    }

    // if (neurodevelopmentalDisorder.text.isEmpty) {
    //   showToast("Child's neurodevelopmental disorder cannot be empty");
    //   return;
    // }

    if (isEditMode == true) {
      await profileService.editProfile(detailProfile!.id ?? "", childsName.text, getBirthDate!, age.value!, selectedGender.value, neurodevelopmentalDisorder.text);
      return;
    } else {
      await profileService.saveNewProfile(childsName.text, getBirthDate!, age.value!, selectedGender.value, neurodevelopmentalDisorder.text);
    }
  }

  Future<void> deleteProfile(String profileId) async {
    await profileService.deleteProfile(profileId);
    Get.offAllNamed(Routes.PROFILE_GALLERY);
  }
}
