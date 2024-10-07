import 'dart:developer';

import 'package:signal_lab/core/utils/method.dart';
import 'package:signal_lab/core/utils/url_container.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';
import 'package:signal_lab/data/services/api_service.dart';

class PlanRepo{

  ApiClient apiClient;
  PlanRepo({required this.apiClient});


  Future<ResponseModel> getPackagesData(int page) async{

    String url = "${UrlContainer.baseUrl}${UrlContainer.packagesEndPoint}?page=$page";
    log("this is Get packages");
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    log(responseModel.responseJson);
    // log(responseModel.responseJson['data']['balance'].toString());

    return responseModel;
  }


  Future<ResponseModel> purchasePackage({required int packageId}) async{

    Map<String, String> map = {"id" : packageId.toString()};
    String url = "${UrlContainer.baseUrl}${UrlContainer.purchasePackageEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    return responseModel;
  }

  Future<ResponseModel> renewPackage({required int packageId}) async{

    Map<String, String> map = {"id" : packageId.toString()};
    String url = "${UrlContainer.baseUrl}${UrlContainer.renewPackageEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    return responseModel;
  }
}