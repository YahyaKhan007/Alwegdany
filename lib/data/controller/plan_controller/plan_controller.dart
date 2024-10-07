import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/util.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';
import 'package:signal_lab/data/model/plan/plan_model.dart';
import 'package:signal_lab/data/repo/plan_repo/plan_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';

class PlanController extends GetxController{

  PlanRepo planRepo;
  PlanController({required this.planRepo});

  bool isLoading = true;
  List<PackageData> packageList = [];
  String currency = '';
  String curSymbol = '';
  var balance = ''.obs;
  String? nextPageUrl;


  Future<void> getAllPackageData() async{

    page = page+1;

    if(page==1){
      currency = planRepo.apiClient.getCurrencyOrUsername();
      curSymbol = planRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
      packageList.clear();
    }

    ResponseModel response = await planRepo.getPackagesData(page);
    if(response.statusCode == 200){
      PlanModel planModel = PlanModel.fromJson(jsonDecode(response.responseJson));
      if(planModel.status?.toLowerCase() == "success"){


        if(page == 1){
          log(planModel.data!.balance.toString());
          balance.value = planModel.data?.balance ?? "0";
          log(balance.value);
        }

        nextPageUrl = planModel.data?.packages?.nextPageUrl ?? '';

        List<PackageData>? tempPackageDataList = planModel.data?.packages?.data;
        if(tempPackageDataList != null && tempPackageDataList.isNotEmpty){
          packageList.addAll(tempPackageDataList);
        }
      }
      else{
        MySnackbar.error(errorList: planModel.message?.error??[MyStrings.requestFail]);
      }
    }
    else{
      MySnackbar.error(errorList: [response.message]);
    }

    isLoading = false;
    update();
  }

  bool purchaseLoading = false;
  Future<void> purchasePackage({required int packageId,required int index}) async{

    purchaseLoading = true;
    update();

    ResponseModel response = await planRepo.purchasePackage(packageId: packageId);

    if(response.statusCode == 200){
      PlanModel planModel = PlanModel.fromJson(jsonDecode(response.responseJson));
      if(planModel.status.toString().toLowerCase() == "success"){
        Get.back();
        MySnackbar.success( msg: planModel.message?.success ?? [MyStrings.planRenewSuccessMsg],);
      }
      else{
        Get.back();
        MySnackbar.error(errorList:planModel.message?.error ?? [MyStrings.requestFail]);
      }
    }
    else{
      Get.back();
      MySnackbar.error(errorList: [response.message]);
    }
    purchaseLoading = false;
    update();
    return;
  }

  bool renewPlanLoading = false;
  Future<Map<String,dynamic>> renewPackage({required int packageId}) async{
    renewPlanLoading = true;
    update();
    ResponseModel response = await planRepo.renewPackage(packageId: packageId);
    List<String>result =  [];
    bool status = false;

    if(response.statusCode == 200){
      PlanModel planModel = PlanModel.fromJson(jsonDecode(response.responseJson));
      if(planModel.status.toString().toLowerCase() == "success"){
        result.addAll(planModel.message?.success??[MyStrings.planRenewSuccessMsg]);
        status = true;
      }
      else{
        MySnackbar.error(errorList: planModel.message?.error??[MyStrings.requestFail]);
        result.addAll(planModel.message?.success??[MyStrings.planRenewSuccessMsg]);
        status = false;
      }
    }
    else{
      result.add(response.message);
      status = false;
    }
    renewPlanLoading = false;
    update();
    return {'status':status,'list':result};
  }

  int selectedIndex = 0;
  void changeSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  int page = 0;
  void loadPaginationData() {
    if(nextPageUrl !=null && nextPageUrl!.isNotEmpty){
      getAllPackageData();
    }
  }

@override
  void onInit() {
       pageController = PageController(initialPage: 0, viewportFraction: .8);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { MyUtil.makePortraitOnly();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PlanRepo(apiClient: Get.find()));
    Get.lazyPut(()=>PlanController(planRepo: Get.find()));
    final controller = Get.find<PlanController>()..getAllPackageData();
  
    });
    super.onInit();
  }

  //  @override
  //  void onInit(){


  //   pageController = PageController(initialPage: 0, viewportFraction: .8);

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) { MyUtil.makePortraitOnly();
  //   Get.put(ApiClient(sharedPreferences: Get.find()));
  //   Get.put(PlanRepo(apiClient: Get.find()));
  //   Get.lazyPut(()=>PlanController(planRepo: Get.find()));
  //   final controller = Get.find<PlanController>()..getAllPackageData();
  //   super.initState();
  //   });
  // }

  late PageController pageController;

  @override
  void dispose() {
    MyUtil.makePortraitAndLandscape();
    super.dispose();
  }

}