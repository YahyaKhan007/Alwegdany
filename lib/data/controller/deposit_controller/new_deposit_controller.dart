

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/helper/my_converter.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/data/model/deposit/deposit_insert/deposit_insert_response_model.dart';
import 'package:signal_lab/data/model/deposit/deposit_method/deposit_method_model.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';

import '../../repo/deposit_repo/deposit_repo.dart';


class NewDepositController extends GetxController{
  DepositRepo depositHistoryRepo;

  NewDepositController({required this.depositHistoryRepo}){
    getDepositMethod();
  }

  bool isLoading = true;

  List<Methods> methodList = [];

  String selectedValue = "";

  String depositLimit = "";
  String charge = "";
  String payable = "";
  String amount = "";
  String fixedCharge = "";
  String currency = '';
  String payableText = '';
  String conversionRate = '';
  String inLocal = '';
  Methods? paymentMethod =  Methods(name: MyStrings.plsSelectOne,id: -1);


  TextEditingController amountController = TextEditingController();

  double rate = 1;
  double mainAmount = 0;
  setPaymentMethod(Methods? method) {
    String amt = amountController.text.toString();
    mainAmount = amt.isEmpty?0:double.tryParse(amt)??0;
    paymentMethod = method;
    depositLimit =
    '${MyConverter.twoDecimalPlaceFixedWithoutRounding(
        method?.minAmount?.toString() ?? '-1')} - ${MyConverter
        .twoDecimalPlaceFixedWithoutRounding(
        method?.maxAmount?.toString() ?? '-1')} $currency';
    changeInfoWidgetValue(mainAmount);
    update();
  }

  Future<void> getDepositMethod() async {
    currency = depositHistoryRepo.apiClient.getCurrencyOrUsername();
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
      return;
    }
    isLoading = false;
    update();
  }

  bool submitLoading = false;
  Future<void> submitDeposit() async {

    if(paymentMethod?.id.toString()=='-1'){
      MySnackbar.error(errorList: [MyStrings.selectAnPaymentGateway]);
      return;
    }

    String amount = amountController.text.toString();
    if (amount.isEmpty) {
      MySnackbar.error(errorList: [MyStrings.enterAnAmount]);
      return;
    }

    submitLoading = true;
    update();

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
        MySnackbar.error(errorList: insertResponseModel.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      MySnackbar.error(errorList: [responseModel.message],);
    }

    submitLoading = false;
    update();

  }



  void changeInfoWidgetValue(double amount){
    if(paymentMethod?.id.toString() == '-1'){
      return;
    }

    mainAmount = amount;
    double percent = double.tryParse(paymentMethod?.percentCharge??'0')??0;
    double percentCharge = (amount*percent)/100;
    double temCharge = double.tryParse(paymentMethod?.fixedCharge??'0')??0;
    double totalCharge = percentCharge+temCharge;
    charge = '${MyConverter.twoDecimalPlaceFixedWithoutRounding('$totalCharge')} $currency';
    double payable = totalCharge + amount;
    payableText = '$payable $currency';

    rate = double.tryParse(paymentMethod?.rate??'0')??0;
    conversionRate = '1 $currency = $rate ${paymentMethod?.currency??''}';
    inLocal = MyConverter.twoDecimalPlaceFixedWithoutRounding('${payable*rate}');
    update();
    return;
  }

  void clearData() {
    depositLimit = '';
    charge = '';
    methodList.clear();
    amountController.text = '';
    isLoading = false;
  }

  bool isShowRate() {
    if(rate>1 && currency.toLowerCase() != paymentMethod?.currency?.toLowerCase()){
      return true;
    }else{
      return false;
    }
  }

  void showWebView(String redirectUrl) {
    Get.offAndToNamed(RouteHelper.depositWebScreen, arguments: redirectUrl);
  }

}