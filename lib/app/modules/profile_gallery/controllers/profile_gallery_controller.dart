import 'package:get/get.dart';
import 'package:satua/app/model/profile_model.dart';
import 'package:satua/app/services/profile_service.dart';

class ProfileGalleryController extends GetxController {
  final ProfileService profileService = ProfileService();
  final RxString selectedSortOption = ''.obs;
  final RxList<Profile> allProfile = <Profile>[].obs;
  

  @override
  void onInit() {
    fetchAllProfile();
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

  Future<void> fetchAllProfile() async {
    List<Profile> fetchedProfileList = await profileService.getAllProfiles();
    allProfile.assignAll(fetchedProfileList);
  }

  void sortProfiles() {
    if (selectedSortOption.value == 'Sort by A from Z') {
      allProfile.sort((a, b) => a.childsName.compareTo(b.childsName));
    } else if (selectedSortOption.value == 'Sort by Z from A') {
      allProfile.sort((a, b) => b.childsName.compareTo(a.childsName));
    } else if (selectedSortOption.value == 'Newest') {
      allProfile.sort((a, b) => b.createTime.compareTo(a.createTime));
    } else if (selectedSortOption.value == 'Oldest') {
      allProfile.sort((a, b) => a.createTime.compareTo(b.createTime));
    }
    allProfile.refresh();
  }
}
