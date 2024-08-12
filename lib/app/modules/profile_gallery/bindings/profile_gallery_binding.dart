import 'package:get/get.dart';

import 'package:satua/app/modules/profile_gallery/controllers/profile_form_controller.dart';

import '../controllers/profile_gallery_controller.dart';

class ProfileGalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileFormController>(
      () => ProfileFormController(),
    );
    Get.lazyPut<ProfileGalleryController>(
      () => ProfileGalleryController(),
    );
  }
}
