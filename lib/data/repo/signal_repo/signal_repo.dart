import 'package:signal_lab/core/utils/method.dart';
import 'package:signal_lab/core/utils/url_container.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';
import 'package:signal_lab/data/services/api_service.dart';

class SignalsRepo{

  ApiClient apiClient;
  SignalsRepo({required this.apiClient});

  Future<ResponseModel> getSignalsData(int page, {String searchText = ""}) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.signalsEndPoint}?page=$page&search=$searchText";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}