import 'dart:convert';

import 'package:get/get.dart';
import 'package:alwegdany/views/components/snackbar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

import '../../model/about/privacy_response_model.dart';
import '../../repo/privacy_repo/privacy_repo.dart';

class PrivacyController extends GetxController {
  int selectedIndex = 1;
  PrivacyRepo repo;
  bool isLoading = true;

  List<PolicyPages> list = [];
  late var selectedHtml = '';

  PrivacyController({required this.repo});

  void loadData() async {
    ResponseModel model = await repo.loadPrivacyAndPolicy();
    if (model.statusCode == 200) {
      PrivacyResponseModel responseModel =
          PrivacyResponseModel.fromJson(jsonDecode(model.responseJson));
      if (responseModel.data?.policyPages != null &&
          !(responseModel.data!.policyPages == [])) {
        list.clear();
        list.addAll(responseModel.data!.policyPages!);
        changeIndex(0);
        updateLoading(false);
      }
    } else {
      MySnackbar.error(errorList: [model.message]);
      updateLoading(false);
    }
  }

  void changeIndex(int index) {
    selectedIndex = index;
    selectedHtml = list[index].dataValues?.description ?? '';
    update();
  }

  updateLoading(bool status) {
    isLoading = status;
    update();
  }
}
