import 'package:alwegdany/core/utils/method.dart';
import 'package:alwegdany/core/utils/url_container.dart';
import 'package:alwegdany/data/model/global/response_model/response_model.dart';
import 'package:alwegdany/data/services/api_service.dart';

class DepositRepo {
  ApiClient apiClient;
  DepositRepo({required this.apiClient});

  Future<ResponseModel> getDepositHistory(int page,
      {String searchText = ""}) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.depositHistoryEndPoint}?page=$page&search=$searchText";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getDepositMethods() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.depositMethodEndPoint}";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> insertDeposit(
      {required String amount,
      required String methodCode,
      required String currency}) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.depositInsertEndPoint}";
    Map<String, String> map = {
      "amount": amount,
      "method_code": methodCode,
      "currency": currency
    };
    ResponseModel responseModel =
        await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return responseModel;
  }
}
