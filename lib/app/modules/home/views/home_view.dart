import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:satua/app/core/theme_manager/assets_manager.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';
import 'package:satua/app/routes/app_pages.dart';
import 'package:satua/app/services/auth_service.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.ellipsis_vertical),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    title: Column(
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          "Logout Confirmation",
                          style: TextStyleManager.titleGreen(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Are you sure you want to logged out?",
                          style: TextStyleManager.regular12(fontSize: 14, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    actionsPadding: const EdgeInsets.fromLTRB(35, 20, 35, 35),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFDE00),
                          textStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                          minimumSize: const Size.fromHeight(50),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => AuthService().logout(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF6F6F6),
                          textStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                          minimumSize: const Size.fromHeight(50),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Color(0xFFBDBDBD), fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Hi Parents!',
                            style: TextStyleManager.titleGreen(),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text(
                            'Let’s create wonderful bedtime stories together with Satua.',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF666666)),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          const Text(
                            'Explore',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.DETAILS);
                            },
                            child: SizedBox(
                              height: 177,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                color: const Color(0xFF8FDEBC),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(25.0, 20.0, 20.0, 20.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Create new Story',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 14,
                                              ),
                                              Text(
                                                'Powered by OpenAI’s creative mind, Satua helps you make the perfect bedtime story for your loved ones.',
                                                maxLines: 4,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        '${AssetManager.imagePath}/cacing-kuning.png',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.STORY_LIST);
                            },
                            child: SizedBox(
                              height: 177,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                color: const Color(0xFFFFF08A),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(25.0, 20.0, 20.0, 20.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Read existing stories',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 14,
                                              ),
                                              Text(
                                                'Skip the hassle of making a new one, and jump right in to read past stories made by other parents!',
                                                maxLines: 4,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Image.asset('${AssetManager.imagePath}/cacing-hijau.png'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.PROFILE_GALLERY);
                            },
                            child: SizedBox(
                              height: 177,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                color: const Color(0xFFFFB18A),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(25.0, 20.0, 20.0, 20.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Create child’s profile',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 14,
                                              ),
                                              Text(
                                                'Set your child’s profile and skip the hassle of filling up your child’s info the next time you want to create a story.',
                                                maxLines: 4,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Image.asset('${AssetManager.imagePath}/cacing-biru.png'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            'Parenting 101',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 22),
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: 177,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                color: const Color(0xFFFFABD8),
                                child: const Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Your kids are a reflection of yourself!',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 14,
                                              ),
                                              Text(
                                                "Always up for a challenge, Sukerti volunteered to save the day. Armed with a courage as big as his heart, he set off to find the dragon's lair. Along the way, ",
                                                style: TextStyle(fontSize: 14),
                                                maxLines: 4,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.TRACKER);
                            },
                            child: SizedBox(
                              height: 177,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                color: const Color(0xFFBED7FC),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(25.0, 20.0, 20.0, 20.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Progress Tracker',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 14,
                                              ),
                                              Text(
                                                'See how often you read. Let’s develop a good habit of reading stories everyday before bed!',
                                                maxLines: 4,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        '${AssetManager.imagePath}/kacang-merah.png',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            'Get to know us',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 22),
                          const Text(
                            "Welcome to Satua, where dreams take flight and bedtime stories come alive! 🌙✨\n\nAt Satua, we believe in the magic of bedtime stories and the power of imagination. We're not just an app; we're your storytelling companion, here to whisk you away to enchanting worlds crafted with love and powered by cutting-edge AI.\n\nOur mission is simple: to transform bedtime into a magical adventure for children and parents alike. Satua, derived from the Indonesian word for 'story',  is more than just an app; it's a gateway to a universe where imagination knows no bounds.",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF666666)),
                          ),
                          const SizedBox(height: 77),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Copyright © 2024 Story.AI. All Rights Reserved.",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Color(0xFF666666)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
