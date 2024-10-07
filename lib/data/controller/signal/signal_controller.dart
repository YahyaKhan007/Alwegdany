import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';
import 'package:signal_lab/data/model/signal/signal_model.dart' as signals;
import 'package:signal_lab/data/repo/signal_repo/signal_repo.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';

class SignalsController extends GetxController{

  SignalsRepo signalsRepo;
  SignalsController({required this.signalsRepo});

  bool isLoading = true;
  List<signals.Data> dataList = [];

  String? nextPageUrl;
  int page = 0;
  String searchSignal = "";

  TextEditingController searchController = TextEditingController();

  void initialSelectedValue() async{
    page = 0;
    dataList.clear();
    isLoading = true;
    update();

    await allSignalsData();
    isLoading = false;
    update();
  }

  void initData() async{
    await allSignalsData();
    isLoading=false;
    update();
  }

  void loadPaginationData()async{
    await allSignalsData();
    update();
  }

  Future<void> allSignalsData() async{

    page = page + 1;
    if(page == 1){
      dataList.clear();
    }

    ResponseModel responseModel = await signalsRepo.getSignalsData(page, searchText: searchSignal);

    if(responseModel.statusCode == 200){
      signals.SignalModel signalModel = signals.SignalModel.fromJson(jsonDecode(responseModel.responseJson));

      nextPageUrl = signalModel.data?.signals?.nextPageUrl;

      if(signalModel.status.toString().toLowerCase() == "success"){
        List<signals.Data>? tempDataList = signalModel.data?.signals?.data;
        if(tempDataList != null && tempDataList.isNotEmpty){
          dataList.addAll(tempDataList);
        }

        if(page==1){
          isLoading = false;
          update();
        }

      }
      else{
        MySnackbar.error(errorList: signalModel.message?.error?? [MyStrings.somethingWentWrong]);
        return ;
      }
    }
    else{
      MySnackbar.error(errorList: [responseModel.message]);
      return ;
    }
  }

  bool filterLoading = false;

  Future<void> filterData()async{
    searchSignal = searchController.text;
    page = 0;
    filterLoading = true;
    update();

    await allSignalsData();

    filterLoading=false;
    update();
  }

  bool hasNext(){
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }

  bool iconPress = false;
  void changeIcon() {
    iconPress = !iconPress;
    update();
  }
}