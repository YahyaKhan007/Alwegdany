import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/helper/my_converter.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/data/model/deposit/deposit_insert/deposit_insert_response_model.dart';
import 'package:signal_lab/data/model/deposit/deposit_method/deposit_method_model.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';
import 'package:signal_lab/data/repo/deposit_repo/deposit_repo.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';
import 'package:signal_lab/data/model/deposit/deposit_history/deposit_history_model.dart';

class DepositController extends GetxController {

  DepositRepo depositHistoryRepo;
  DepositController({required this.depositHistoryRepo});

  bool isLoading = true;
  List<Methods> methodList = [];
  List<DepositData> depositHistoryList = [];
  Methods? paymentMethod = Methods();

  String selectedValue = "";
  String depositLimit = "";
  String charge = "";
  String payable = "";
  String amount = "";
  String fixedCharge = "";
  String currency = '';
  String searchText = "";
  int page = 0;
  String? nextPageUrl;

  TextEditingController amountController = TextEditingController();
  TextEditingController searchController = TextEditingController();


  void initData() async {
    page = 0;
    isLoading = true;
    update();
    await getAllDepositHistory();
    isLoading = false;
    update();
  }

  void loadPaginationData() async {
    await getAllDepositHistory();
    update();
  }

  Future<void> getAllDepositHistory() async {
    page = page + 1;
    if (page == 1) {
      depositHistoryList.clear();
    }

    ResponseModel responseModel = await depositHistoryRepo
        .getDepositHistory(page, searchText: searchText);
    if (responseModel.statusCode == 200) {
      DepositHistoryModel model =
          DepositHistoryModel.fromJson(jsonDecode(responseModel.responseJson));

      nextPageUrl = model.data?.deposits?.nextPageUrl;

      if (model.status.toString().toLowerCase() == "success") {
        List<DepositData>? tempHistoryList = model.data?.deposits?.data;
        if (tempHistoryList != null && tempHistoryList.isNotEmpty) {
          depositHistoryList.addAll(tempHistoryList);
        }

        if (page == 1) {
          isLoading = false;
          update();
        }
      } else {
        MySnackbar.error(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
        return;
      }
    } else {
      MySnackbar.error(errorList: [responseModel.message]);
      return;
    }
  }

  setPaymentMethod(Methods? method) {
    paymentMethod = method;
    depositLimit =
        '${MyConverter.twoDecimalPlaceFixedWithoutRounding(method?.minAmount?.toString() ?? '-1')} ${method?.currency.toString()} - ${MyConverter.twoDecimalPlaceFixedWithoutRounding(method?.maxAmount?.toString() ?? '-1')} ${method?.currency.toString()}';
    fixedCharge =
        "${double.parse(MyConverter.twoDecimalPlaceFixedWithoutRounding(method?.fixedCharge?.toString() ?? '0'))}";
    charge =
        '${double.parse(fixedCharge) + (double.parse(MyConverter.twoDecimalPlaceFixedWithoutRounding(amount)) / 100)}';
    payable = "${double.parse(amount) + double.parse(charge)}";
    update();
  }

  Future<void> getDepositMethod() async {
    ResponseModel responseModel = await depositHistoryRepo.getDepositMethods();
    if (responseModel.statusCode == 200) {
      DepositMethodsModel methodsModel =
          DepositMethodsModel.fromJson(jsonDecode(responseModel.responseJson));

      if (methodsModel.message != null &&
          methodsModel.message!.success != null) {
        List<Methods>? tempList = methodsModel.data?.methods;
        if (tempList != null && tempList.isNotEmpty) {
          methodList.addAll(tempList);
        }
      }
    } else {
      MySnackbar.error(errorList: [responseModel.message]);
    }
    isLoading = false;
    update();
  }

  Future<void> submitDeposit() async {
    String amount = amountController.text.toString();
    if (amount.isEmpty) {
      return;
    }

    ResponseModel responseModel = await depositHistoryRepo.insertDeposit(
        amount: amount,
        methodCode: paymentMethod?.methodCode ?? "",
        currency: paymentMethod?.currency ?? "");

    if (responseModel.statusCode == 200) {
      DepositInsertResponseModel insertResponseModel =
          DepositInsertResponseModel.fromJson(
              jsonDecode(responseModel.responseJson));
      if (insertResponseModel.status.toString().toLowerCase() == "success") {
        showWebView(insertResponseModel.data?.redirectUrl ?? "");
      } else {
        MySnackbar.error(
            errorList: insertResponseModel.message?.error ??
                [MyStrings.somethingWentWrong]);
        return;
      }
    } else {
      MySnackbar.error(
        errorList: [responseModel.message],
      );
      return;
    }
  }

  void showWebView(String redirectUrl) {
    Get.toNamed(RouteHelper.depositWebScreen, arguments: redirectUrl);
  }

  bool filterLoading = false;

  Future<void> filterData() async {
    searchText = searchController.text;
    page = 0;
    filterLoading = true;
    update();
    await getAllDepositHistory();
    filterLoading = false;
    update();
  }

  bool isSearch = false;
  void changeSearchStatus(){
    isSearch = ! isSearch;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null &&
            nextPageUrl!.isNotEmpty &&
            nextPageUrl != 'null'
        ? true
        : false;
  }

  String getStatus(int index) {
    String status = depositHistoryList[index].status??'';
    String methodCode = depositHistoryList[index].methodCode??'1';
    if(status == '1'){
      double code = double.tryParse(methodCode)??1;
      return code>=1000? MyStrings.approved : MyStrings.succeed ;
    } else{
      return status == '2'? MyStrings.pending : status == '3'? MyStrings.rejected : MyStrings.initiated;
    }
  }

 Color getStatusColor(int index) {
    String status = depositHistoryList[index].status??'';
    String methodCode = depositHistoryList[index].methodCode??'1';
    if(status == '1'){
      double code = double.tryParse(methodCode)??1;
      return code >= 1000? MyColor.highPriorityPurpleColor
          : MyColor.greenSuccessColor;
    } else{
      return status == '2' ? MyColor.pendingColor : status == '3'? MyColor.redCancelTextColor : MyColor.colorGrey;
    }
  }

  String getAmount(int index) {
    double mainAmount = double.parse(depositHistoryList[index].amount ?? "0") + double.parse(depositHistoryList[index].charge ?? "0");
    String formatedValue = MyConverter.twoDecimalPlaceFixedWithoutRounding(mainAmount.toString());
    return formatedValue;
  }

}

