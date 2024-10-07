import 'dart:developer';

import 'package:signal_lab/core/utils/method.dart';
import 'package:signal_lab/core/utils/url_container.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';
import 'package:signal_lab/data/services/api_service.dart';

class HomeRepo{
  ApiClient apiClient;
  HomeRepo({required this.apiClient});

  Future<ResponseModel> getDashboardData()async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.userDashboardEndPoint}";
log("This is Check 1 fro dashboard url $url");
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}