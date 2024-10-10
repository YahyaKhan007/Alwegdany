import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:alwegdany/core/helper/date_converter.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/data/model/bottom_nav/home/dashboard_model.dart';
import 'package:alwegdany/data/model/global/response_model/response_model.dart';
import 'package:alwegdany/data/repo/bottom_nav/home/dashboard_repo.dart';
import 'package:alwegdany/views/components/snackbar/show_custom_snackbar.dart';

class HomeController extends GetxController {
  HomeRepo dashboardRepo;
  HomeController({required this.dashboardRepo});

  bool isLoading = true;
  List<LatestSignals> signalsList = [];

  String totalTrx = '';
  String totalSignal = "";
  String totalDeposit = "";
  String totalReferral = "";
  String referralLink = "";
  String balance = "";

  String packageId = "";
  String packageName = "";
  String packageTime = "";
  String packagePrice = "";
  String packageValidity = "";

  String currencySymbol = '';
  String currency = '';

  Future<void> getDashboardData() async {
    currencySymbol = dashboardRepo.apiClient
        .getCurrencyOrUsername(isCurrency: true, isSymbol: true);
    currency = dashboardRepo.apiClient
        .getCurrencyOrUsername(isCurrency: true, isSymbol: false);
    signalsList.clear();

    ResponseModel responseModel = await dashboardRepo.getDashboardData();

    try {
      if (responseModel.statusCode == 200) {
        log("Came in the body");
        // log()
        DashboardModel dashboardModel =
            DashboardModel.fromJson(jsonDecode(responseModel.responseJson));
        if (dashboardModel.status.toString().toLowerCase() == "success") {
          List<LatestSignals>? tempSignalList =
              dashboardModel.data?.latestSignals;
          totalTrx = dashboardModel.data?.totalTrx ?? '00';
          totalSignal = dashboardModel.data?.totalSignal ?? "00";
          totalDeposit = dashboardModel.data?.totalDeposit ?? "00";
          totalReferral = dashboardModel.data?.totalReferral ?? "00";
          referralLink = dashboardModel.data?.referralLink ?? "00";
          balance = dashboardModel.data?.user?.balance ?? "00";

          packageName =
              dashboardModel.data?.user?.package?.name ?? "Package: N/A";
          String planTime = dashboardModel.data?.user?.validity ?? "";

          packageTime = planTime.isEmpty
              ? '---'
              : DateConverter.formatValidityDate(planTime);
          packagePrice = dashboardModel.data?.user?.package?.price ?? "";
          packageValidity = dashboardModel.data?.user?.package?.validity ?? "";
          packageId = dashboardModel.data?.user?.package?.id.toString() ?? "";

          if (tempSignalList != null && tempSignalList.isNotEmpty) {
            signalsList.addAll(tempSignalList);
          }
        } else {
          MySnackbar.error(
              errorList: dashboardModel.message?.error ??
                  [MyStrings.somethingWentWrong]);
        }
      } else {
        MySnackbar.error(errorList: [responseModel.message]);
      }
    } catch (e, stackTrace) {
      print("===>  stackTrace\t\t:\t\t$e\n$stackTrace");
    }

    isLoading = false;
    update();
  }

  // getBanners(){

  // }
}
