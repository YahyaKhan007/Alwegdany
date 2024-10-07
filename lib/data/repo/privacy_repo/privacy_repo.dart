import 'package:signal_lab/core/utils/method.dart';

import '../../../core/utils/url_container.dart';
import '../../../data/services/api_service.dart';

class PrivacyRepo{

  ApiClient apiClient;
  PrivacyRepo({required this.apiClient});

  Future<dynamic>loadPrivacyAndPolicy()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.privacyPolicyEndPoint}';
    final response=await apiClient.request(url,Method.getMethod,null);
    return response;
  }

}