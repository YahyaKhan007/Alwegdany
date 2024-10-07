class UrlContainer {
  //static const String baseUrl = 'https://projecturl.com/';
  static const String baseUrl = 'https://alwegdany.com/';

  static const String loginEndPoint = 'api/login';
  static const String referralEndPoint = "api/referrals";
  static const String registrationEndPoint = 'api/register';
  static const String userDashboardEndPoint = 'api/dashboard';
  static const String forgetPasswordEndPoint = 'api/password/email';
  static const String passwordVerifyEndPoint = 'api/password/verify-code';
  static const String resetPasswordEndPoint = 'api/password/reset';
  static const String countryEndPoint = 'api/get-countries';

  // pricing plan
  static const String packagesEndPoint = "api/packages";
  static const String purchasePackageEndPoint = "api/purchase/package";
  static const String renewPackageEndPoint = "api/renew/package";

  // signals
  static const String signalsEndPoint = "api/signals";

  static const String verifyEmailEndPoint = 'api/verify-email';
  static const String verifySmsEndPoint = 'api/verify-mobile';
  static const String verify2FAUrl = 'api/verify-g2fa';
  static const String resendVerifyCodeEndPoint = 'api/resend-verify/';

  static const String depositHistoryEndPoint = 'api/deposit/history';
  static const String depositMethodEndPoint = 'api/deposit/methods';
  static const String depositInsertEndPoint = 'api/deposit/insert';

  static const String authorizationCodeEndPoint = 'api/authorization';
  static const String generalSettingEndPoint = 'api/general-setting';
  static const String privacyPolicyEndPoint = 'api/policy/pages';

  static const String getProfileEndPoint = 'api/user-info';
  static const String updateProfileEndPoint = 'api/profile-setting';
  static const String profileCompleteEndPoint = 'api/user-data-submit';
  static const String changePasswordEndPoint = 'api/change-password';

  // transaction
  static const String transactionEndpoint = 'api/transactions';
  static const String deviceTokenEndPoint = 'api/get/device/token';
  static const String logout = 'api/logout';

  // ^ Extra API's

  static const String faqs = 'api/faqs';
}
