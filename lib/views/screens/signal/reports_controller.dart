import 'package:get/get.dart';

import '../../../core/new_api_services/new_api_service.dart';
import '../../../data/model/reports/reports_model.dart';

class ReportsController extends GetxController {
  var reportsList = <ReportsDataModel>[].obs;
  late final NewApiClient apiClient;

  @override
  void onInit() {
    apiClient = NewApiClient();

    super.onInit();
  }
}
