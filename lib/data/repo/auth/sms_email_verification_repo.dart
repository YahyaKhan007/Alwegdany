import 'dart:convert';
import 'package:signal_lab/core/utils/method.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/url_container.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';

import '../../model/authorization/authorization_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class SmsEmailVerificationRepo {
  ApiClient apiClient;

  SmsEmailVerificationRepo({required this.apiClient});

  Future<ResponseModel> verify(String code,
      {bool isEmail = true, bool isTFA = false}) async {
    final map = {
      'code': code,
    };

    String url = '${UrlContainer.baseUrl}${isEmail ? UrlContainer.verifyEmailEndPoint : UrlContainer.verifySmsEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    return responseModel;
  }


  Future<bool> sendAuthorizationRequest() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.authorizationCodeEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    if (response.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
          jsonDecode(response.responseJson));
      if (model.status == 'error') {
        MySnackbar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong],);
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resendVerifyCode({required bool isEmail}) async {
    final url = '${UrlContainer.baseUrl}${UrlContainer.resendVerifyCodeEndPoint}${isEmail ? 'email' : 'mobile'}';

    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    if (response.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
          jsonDecode(response.responseJson));

      if (model.status == 'error') {
        MySnackbar.error(errorList: model.message?.error ?? [MyStrings.resendCodeFail],);
        return false;
      } else {
        MySnackbar.success(msg: model.message?.success ?? [MyStrings.successfullyCodeResend]);
        return true;
      }
    } else {
      return false;
    }
  }
}
