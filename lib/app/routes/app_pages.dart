import 'package:get/get.dart';

import '../modules/details/bindings/details_binding.dart';
import '../modules/details/views/details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/loading_1/bindings/loading_1_binding.dart';
import '../modules/loading_1/views/loading_1_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile_gallery/bindings/profile_gallery_binding.dart';
import '../modules/profile_gallery/views/profile_gallery_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/result/bindings/result_binding.dart';
import '../modules/result/views/result_view.dart';
import '../modules/story_list/bindings/story_list_binding.dart';
import '../modules/story_list/views/story_list_view.dart';
import '../modules/tracker/bindings/tracker_binding.dart';
import '../modules/tracker/views/tracker_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.REGISTER;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAILS,
      page: () => const DetailsView(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOADING_1,
      page: () => const Loading1View(),
      binding: Loading1Binding(),
    ),
    GetPage(
      name: _Paths.STORY_LIST,
      page: () => const StoryListView(),
      binding: StoryListBinding(),
    ),
    GetPage(
      name: _Paths.RESULT,
      page: () => const ResultView(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: _Paths.TRACKER,
      page: () => const TrackerView(),
      binding: TrackerBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_GALLERY,
      page: () => const ProfileGalleryView(),
      binding: ProfileGalleryBinding(),
    ),
  ];
}
