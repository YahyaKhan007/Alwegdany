import 'package:get/get.dart';
import 'package:signal_lab/data/model/banner_model/banner_model.dart';

import '../../../../core/new_api_services/new_api_service.dart';

class BannerController extends GetxController {
  var bannersList = <BannerModel>[].obs;
  late final NewApiClient apiClient;

  @override
  void onInit() {
    apiClient = NewApiClient();

    super.onInit();
  }
}
