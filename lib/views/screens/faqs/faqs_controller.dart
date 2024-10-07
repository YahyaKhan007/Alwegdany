import 'package:get/get.dart';
import 'package:signal_lab/data/model/faqs/faqs_model.dart';

import '../../../core/new_api_services/new_api_service.dart';

class FAQsController extends GetxController {
  var faqsList = <FAQsModel>[].obs;

  @override
  void onInit() {
    // final NewApiClient apiClient = NewApiClient();

    super.onInit();
  }
}
