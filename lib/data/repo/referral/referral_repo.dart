import 'package:signal_lab/core/utils/method.dart';
import 'package:signal_lab/core/utils/url_container.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';
import 'package:signal_lab/data/services/api_service.dart';

class ReferralRepo{
  ApiClient apiClient;
  ReferralRepo({required this.apiClient});

  Future<ResponseModel> getReferralData(int page, {String searchText = ""})async{

    String url = "${UrlContainer.baseUrl}${UrlContainer.referralEndPoint}?page=$page&search=$searchText";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;

  }
}