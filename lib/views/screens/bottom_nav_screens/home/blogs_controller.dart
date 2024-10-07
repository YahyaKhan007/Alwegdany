import 'package:get/get.dart';

import '../../../../core/new_api_services/new_api_service.dart';
import '../../../../data/model/blogs_model/blogs_model.dart';

class BlogsController extends GetxController {
  var blogsList = <BlogsDataModel>[].obs;
  late final NewApiClient apiClient;

  @override
  void onInit() {
    apiClient = NewApiClient();

    super.onInit();
  }
}
