import 'dart:convert';
import 'package:signal_lab/core/helper/my_converter.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/data/model/authorization/authorization_response_model.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';

import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class ChangePasswordRepo {
  ApiClient apiClient;

  ChangePasswordRepo({required this.apiClient});

  String token = '', tokenType = '';

  Future<bool> changePassword(String currentPass, String password) async {
    final params = modelToMap(currentPass, password);
    String url = '${UrlContainer.baseUrl}${UrlContainer.changePasswordEndPoint}';

    ResponseModel responseModel = await apiClient
        .request(url, Method.postMethod, params, passHeader: true);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));
      if (model.status?.toLowerCase() == 'success') {
        MySnackbar.success(msg: model.message?.success ?? [MyStrings.requestSuccess]);
        return true;
      } else {
        List<String>message = model.message?.error ?? [MyStrings.requestFail];
        String value = MyConverter.removeQuotationAndSpecialCharacterFromString(message.toString());
        List<String>list=value.split(',');
        MySnackbar.error(errorList:list.isEmpty?[MyStrings.requestFail]:list);
        return false;
      }
    } else {
      return false;
    }
  }

  modelToMap(String currentPassword, String newPass) {
    Map<String, dynamic> map2 = {
      'current_password' : currentPassword,
      'password' : newPass,
      'password_confirmation' : newPass
    };
    return map2;
  }
}
