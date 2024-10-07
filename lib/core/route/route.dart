import 'package:get/get.dart';
import 'package:signal_lab/views/screens/account/change-password/change_password_screen.dart';
import 'package:signal_lab/views/screens/auth/email_verification/email_verification_screen.dart';
import 'package:signal_lab/views/screens/auth/forget_password/forget_password/forget_password.dart';
import 'package:signal_lab/views/screens/auth/forget_password/reset_pass/reset_pass_screen.dart';
import 'package:signal_lab/views/screens/auth/forget_password/verify_forget_password_code_screen/verify_forget_pass_code.dart';
import 'package:signal_lab/views/screens/auth/profile_complete/profile_complete_screen.dart';
import 'package:signal_lab/views/screens/auth/sms_verification/sms_verification_screen.dart';
import 'package:signal_lab/views/screens/auth/two_factor_screen/two_factor_verification_screen.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/home/home_screen.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/menu/menu_screen.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/pricing-plan/plan_screen.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/trade_screen.dart/trade_signals.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/transaction-history/transaction_history_screen.dart';
import 'package:signal_lab/views/screens/deposit/deposit-history/deposit_history_screen.dart';
import 'package:signal_lab/views/screens/deposit/deposit-now/deposit_now_screen.dart';
import 'package:signal_lab/views/screens/deposit/deposit-now/deposit_web_view.dart';
import 'package:signal_lab/views/screens/onboarding/onBoardingScreen.dart';
import 'package:signal_lab/views/screens/privacy-policy/privacy_policy_screen.dart';
import 'package:signal_lab/views/screens/auth/login/sign_in_screen.dart';
import 'package:signal_lab/views/screens/auth/registration/sign_up_screen.dart';
import 'package:signal_lab/views/screens/profile/edit-profile/edit_profile_screen.dart';
import 'package:signal_lab/views/screens/profile/user-profile/user_profile_screen.dart';
import 'package:signal_lab/views/screens/referral/referral_screen.dart';
import 'package:signal_lab/views/screens/signal/signal_screen.dart';
import 'package:signal_lab/views/screens/splash/splash_screen.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String tradeSignalScreen = "/trade_signal_screen";
  static const String onBoardScreen = "/onboard_screen";
  static const String signInScreen = "/login_screen";
  static const String signUpScreen = "/sign_up_screen";
  static const String bottomNav = "/bottom_nav_bar";
  static const String homeScreen = "/home_screen";
  static const String pricingScreen = "/pricing_screen";
  static const String notificationScreen = "/notification_screen";
  static const String menuScreen = "/menu_screen";
  static const String userProfileScreen = "/user_profile_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String changePasswordScreen = "/change_password_screen";
  static const String transactionHistoryScreen = "/transaction_history_screen";
  static const String depositHistoryScreen = "/deposit_history_screen";
  static const String depositNowScreen = "/deposit_now_screen";
  static const String privacyPolicyScreen = "/privacy_policy_screen";
  static const String depositWebScreen = "/deposit_web_view_screen";
  static const String signalScreen = "/signal_screen";
  static const String forgotPasswordScreen = "/forget_password_screen";
  static const String verifyPassCodeScreen = '/verify-pass-code';
  static const String resetPasswordScreen = '/reset-pass';
  static const String profileCompleteScreen = "/profile_complete_screen";
  static const String emailVerificationScreen = "/email_verification_screen";
  static const String smsVerificationScreen = "/sms_verification_screen";
  static const String referralScreen = "/referral_screen";
  static const String twoFactorScreen = "/two-factor-screen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(
        name: tradeSignalScreen,
        page: () => const TradeSignalWiddget(
              showBack: false,
            )),
    GetPage(name: onBoardScreen, page: () => const OnBoardingScreen()),
    GetPage(name: signInScreen, page: () => const SignInScreen()),
    GetPage(name: signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(
        name: pricingScreen,
        page: () => PlanScreen(
            // showBack: false,
            )),
    GetPage(name: menuScreen, page: () => const MenuScreen()),
    GetPage(name: userProfileScreen, page: () => const UserProfileScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(
        name: changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(
        name: transactionHistoryScreen,
        page: () => const TransactionHistoryScreen()),
    GetPage(
        name: depositHistoryScreen, page: () => const DepositHistoryScreen()),
    GetPage(name: depositNowScreen, page: () => const DepositNowScreen()),
    GetPage(name: privacyPolicyScreen, page: () => const PrivacyScreen()),
    GetPage(
        name: depositWebScreen,
        page: () => DepositWebView(redirectUrl: Get.arguments)),
    GetPage(name: signalScreen, page: () => const SignalScreen()),
    GetPage(
        name: emailVerificationScreen,
        page: () => EmailVerificationScreen(
              needSmsVerification: Get.arguments[0],
              isProfileCompleteEnabled: Get.arguments[1],
              needTwoFactor: Get.arguments[2],
            )),
    GetPage(
        name: smsVerificationScreen, page: () => const SmsVerificationScreen()),
    GetPage(
        name: profileCompleteScreen, page: () => const ProfileCompleteScreen()),

    //forget password
    GetPage(
        name: forgotPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(
        name: verifyPassCodeScreen, page: () => const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: referralScreen, page: () => const ReferralScreen()),
    GetPage(
        name: twoFactorScreen,
        page: () => TwoFactorVerificationScreen(
              isProfileCompleteEnable: Get.arguments,
            )),
  ];
}
