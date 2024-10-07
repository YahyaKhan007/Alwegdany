import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/views/screens/onboarding/widget/customButton.dart';
import 'package:signal_lab/views/screens/onboarding/widget/onBoarding.dart';
import 'package:signal_lab/views/screens/onboarding/widget/onBoardingBottomButton.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  int currentPageIndex = 0;
  bool isLastIndex = false;

  void updateIsLastIndex() {
    if (currentPageIndex == 2) {
      setState(() {
        isLastIndex = true;
      });
    } else {
      setState(() {
        isLastIndex = false;
      });
    }

    // notifyListeners();
  }

  void updatePageIndicator(index) {
    setState(() {
      currentPageIndex = index;
    });
    updateIsLastIndex();
    // rebuildUi();
  }

  void dorNavigationClick(index) {
    setState(() {
      currentPageIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    updateIsLastIndex();
    // notifyListeners();
  }

  void skipPage() {
    setState(() {
      currentPageIndex = 2;
    });
    pageController.animateToPage(
      2,
      duration:
          const Duration(milliseconds: 500), // Adjust the duration as needed
      curve: Curves.easeInOut,
    );
    updateIsLastIndex();
    // notifyListeners();
  }

  void nextPage() {
    if (currentPageIndex == 2) {
    } else {
      int page = 0;
      setState(() {
        page = currentPageIndex + 1;
      });
      pageController.animateToPage(
        page,
        duration:
            const Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut,
      );
      updateIsLastIndex();
    }
    // notifyListeners();
  }

  Future<void> markOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
  }

  void onTapGetStated() {
    markOnboardingSeen();
    Get.offAndToNamed(RouteHelper.signInScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: updatePageIndicator,
            children: const [
              OnBoarding(
                imageAssetPath: 'assets/images/1.png',
                titleText: 'توصيات',
                subtitleText:
                    "تابع أحدث التوصيات عبر تطبيق الوجداني لحظة بالحظة ",
              ),
              OnBoarding(
                imageAssetPath: 'assets/images/2.png',
                titleText: 'احدث الاخبار والتقارير',
                subtitleText:
                    'احصل على اخر الاخبار والتقارير التي \nسوف تساعدك على معرفة السوق',
              ),
              OnBoarding(
                imageAssetPath: 'assets/images/3.png',
                titleText: 'باقات وخيارات متعددة',
                subtitleText:
                    'من المهم جدًا أن يتابع العميل تدريب\n العميل، ولكنه في نفس وقت العمل',
              ),
            ],
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.27,
              left: 0,
              right: 0,
              // left: MediaQuery.of(context).size.width /,
              child: Align(
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                  controller: pageController,
                  onDotClicked: dorNavigationClick,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.black, dotHeight: 10),
                ),
              )),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: Visibility(
              visible: isLastIndex,
              child: CustomButton(
                onTap: onTapGetStated,
                buttonText: 'Get Started',
                backgroundColor: MyColor.primaryColor,
              ),
            ),
          ),
          Visibility(
            visible: !isLastIndex,
            child: OnBoardingBottomButtons(
              onSkip: skipPage,
              onContinue: nextPage,
            ),
          ),
        ],
      ),
    );
  }
}
