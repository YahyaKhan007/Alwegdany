import 'package:alwegdany/core/utils/method.dart';
import 'package:alwegdany/core/utils/url_container.dart';

import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class TwoFactorRepo {
  ApiClient apiClient;

  TwoFactorRepo({required this.apiClient});

  Future<ResponseModel> verify(String code) async {
    final map = {
      'code': code,
    };

    String url = '${UrlContainer.baseUrl}${UrlContainer.verify2FAUrl}';
    ResponseModel responseModel =
        await apiClient.request(url, Method.postMethod, map, passHeader: true);

    return responseModel;
  }
}
