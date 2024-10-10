import 'dart:convert';
import 'dart:developer';

import 'package:alwegdany/core/utils/method.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/utils/url_container.dart';
import 'package:alwegdany/data/model/account/profile_response_model.dart';
import 'package:alwegdany/data/model/authorization/authorization_response_model.dart';
import 'package:alwegdany/data/model/global/response_model/response_model.dart';
import 'package:alwegdany/data/model/user/edit_profile/user_post_model.dart';
import 'package:alwegdany/data/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:alwegdany/views/components/snackbar/show_custom_snackbar.dart';

class UserProfileRepo {
  ApiClient apiClient;
  UserProfileRepo({required this.apiClient});

  Future<ResponseModel> getUserInfo() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}";
    log("this is check 2 from User Profile getting ---- >  url $url");
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    log("End of check 2 from User Profile getting ---- >  url $url");

    return responseModel;
  }

  Future<bool> updateProfile(UserPostModel m, bool isProfile) async {
    try {
      apiClient.initToken();

      String url =
          '${UrlContainer.baseUrl}${isProfile ? UrlContainer.updateProfileEndPoint : UrlContainer.profileCompleteEndPoint}';

      var request = http.MultipartRequest('POST', Uri.parse(url));
      Map<String, String> finalMap = {
        'firstname': m.firstname,
        'lastname': m.lastName,
        'address': m.address ?? '',
        'zip': m.zip ?? '',
        'state': m.state ?? "",
        'city': m.city ?? '',
        'telegram_username': m.telegramUsername ?? '',
      };

      request.headers.addAll(
          <String, String>{'Authorization': 'Bearer ${apiClient.token}'});
      if (m.image != null) {
        request.files.add(http.MultipartFile(
            'image', m.image!.readAsBytes().asStream(), m.image!.lengthSync(),
            filename: m.image!.path.split('/').last));
      }
      request.fields.addAll(finalMap);

      http.StreamedResponse response = await request.send();

      String jsonResponse = await response.stream.bytesToString();
      AuthorizationResponseModel model =
          AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        MySnackbar.success(msg: model.message?.success ?? [MyStrings.success]);
        return true;
      } else {
        MySnackbar.error(
            errorList: model.message?.error ?? [MyStrings.requestFail]);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<ProfileResponseModel> loadProfileInfo() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';
    log("this is check 3 from User Profile getting ---- >  url $url");

    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    log("End of check 3 from User Profile getting ---- >  url $url");

    if (responseModel.statusCode == 200) {
      ProfileResponseModel model =
          ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'success') {
        return model;
      } else {
        return ProfileResponseModel();
      }
    } else {
      return ProfileResponseModel();
    }
  }
}
