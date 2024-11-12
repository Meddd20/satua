import 'package:get/get.dart';

import 'package:satua/app/modules/home/controllers/edit_profile_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
