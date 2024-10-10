import 'dart:developer';

import 'package:alwegdany/core/utils/method.dart';
import 'package:alwegdany/core/utils/url_container.dart';
import 'package:alwegdany/data/model/global/response_model/response_model.dart';
import 'package:alwegdany/data/services/api_service.dart';

class HomeRepo {
  ApiClient apiClient;
  HomeRepo({required this.apiClient});

  Future<ResponseModel> getDashboardData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.userDashboardEndPoint}";
    log("This is Check 1 fro dashboard url $url");
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}
