import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_images.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/menu/menu_controller.dart' as menu;
import 'package:signal_lab/data/controller/translation_controller/translation_controller.dart';
import 'package:signal_lab/data/repo/menu_repo/menu_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:signal_lab/views/components/divider/custom_divider.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/menu/widget/menu_top_card.dart';
import 'package:signal_lab/views/screens/faqs/faqs_screen.dart';

import '../home/widget/home_screen_bottom.dart';
import 'widget/icon_with_text_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MenuRepo(apiClient: Get.find()));
    Get.put(menu.MenuController(repo: Get.find()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var translationController = Get.put(TranslationController());

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.backgroundColor,
        appBar: AppBar(
          title: Text(MyStrings.userMenu.tr,
              style:
                  interNormalDefaultLarge.copyWith(color: MyColor.colorBlack)),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColor.backgroundColor,
        ),
        body: GetBuilder<menu.MenuController>(
            builder: (controller) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        const MenuTopCard(),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: MyColor.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                width: size.width,
                                decoration: const BoxDecoration(
                                  color: MyColor.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    // bottomLeft: Radius.circular(10),
                                    // bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    // Get.to(() =>
                                    // GetBuilder<FAQsController>(
                                    //       builder: (controller) {
                                    //         return const FAQsScreen();
                                    //       },
                                    //     ));
                                    Get.to(() => const FAQsScreen());
                                  },
                                  contentPadding: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  leading: Image.asset(
                                    'assets/images/user.png',
                                    color: Colors.white,
                                    height: 22,
                                    width: 22,
                                  ),
                                  minLeadingWidth: 30,
                                  title: Text('الأسئلة الشائعة'.tr,
                                      style: interNormalDefault.copyWith(
                                          color: MyColor.colorWhite,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  endIndent: 0,
                                  height: 0,
                                ),
                              ),
                              Obx(
                                () => Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: MyColor.primaryColor,
                                  ),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.translate_outlined,
                                      color: Colors.white,
                                    ),
                                    horizontalTitleGap: 22,
                                    title: const Text(
                                      'English',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    trailing: Switch.adaptive(
                                        activeColor: MyColor.primaryColor,
                                        activeTrackColor: Colors.black45,
                                        value:
                                            translationController.english.value,
                                        onChanged: (value) {
                                          translationController.changeLanguage(
                                              isEnglish: value);
                                          translationController.changeLocal(
                                              langCode: translationController
                                                      .english.value
                                                  ? 'en_US'
                                                  : 'ar');
                                          Get.offAndToNamed(
                                              RouteHelper.menuScreen);
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 0),

                        // Container(
                        //   height: 0.6,
                        //   color: const Color.fromARGB(255, 25, 119, 78),
                        //   width: size.width,
                        //   padding: const EdgeInsetsDirectional.symmetric(
                        //       horizontal: 15),
                        //   child: Container(
                        //     height: 0.3,
                        //     color: Colors.black45,
                        //     width: size.width,
                        //   ),
                        // ),
                        // Container(
                        //   height: 60,
                        //   width: size.width,
                        //   decoration: const BoxDecoration(
                        //     color: MyColor.primaryColor,
                        //     borderRadius: BorderRadius.only(
                        //         bottomLeft: Radius.circular(10),
                        //         bottomRight: Radius.circular(10)),
                        //   ),
                        //   child: ListTile(
                        //     onTap: () {
                        //       // Get.to(() =>
                        //       // GetBuilder<FAQsController>(
                        //       //       builder: (controller) {
                        //       //         return const FAQsScreen();
                        //       //       },
                        //       //     ));
                        //       // Get.to(() => ShowAllReports());
                        //     },
                        //     contentPadding: const EdgeInsets.only(right: 15),
                        //     leading: Image.asset(
                        //       'assets/images/boy.png',
                        //       color: Colors.white,
                        //       height: 22,
                        //       width: 22,
                        //     ),
                        //     minLeadingWidth: 30,
                        //     title: Text('About US',
                        //         style: interNormalDefault.copyWith(
                        //             color: MyColor.colorWhite,
                        //             fontWeight: FontWeight.w500)),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: MyColor.primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper.privacyPolicyScreen);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: MyColor.primaryColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IconWithTextWidget(
                                          icon: MyImages.privacy.tr,
                                          text: MyStrings.privacyPolicy.tr),
                                      const CustomDivider(
                                          space: Dimensions.space20)
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.logout();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: MyColor.primaryColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: controller.logoutLoading
                                      ? const Center(
                                          child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: CircularProgressIndicator(
                                                color: MyColor.backgroundColor,
                                              )),
                                        )
                                      : IconWithTextWidget(
                                          icon: MyImages.signOutIcon,
                                          text: MyStrings.signOut.tr),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 20),
                        const HomeScreenBottom(),
                      ],
                    ),
                  ),
                )),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
      ),
    );
  }
}
