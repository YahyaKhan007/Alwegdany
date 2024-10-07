

import 'dart:convert';

import 'package:get/get.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/data/model/authorization/authorization_response_model.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';
import 'package:signal_lab/data/repo/menu_repo/menu_repo.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';


class MenuController extends GetxController{

  MenuRepo repo;
  MenuController({required this.repo});

  bool logoutLoading = false;

  Future<void>logout()async{
    logoutLoading = true;
    update();
    ResponseModel response = await repo.logout();
    if(response.statusCode == 200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase() == MyStrings.success.toLowerCase()){
        MySnackbar.success(msg: model.message?.success??[MyStrings.logoutSuccessMsg]);
      } else{
        MySnackbar.success(msg:[MyStrings.logoutSuccessMsg]);
      }
    }
    logoutLoading = false;
    update();
    Get.offAllNamed(RouteHelper.signInScreen);

  }

}