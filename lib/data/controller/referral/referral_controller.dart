import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/data/model/global/response_model/response_model.dart';
import 'package:alwegdany/data/model/referral/referral_model.dart';
import 'package:alwegdany/data/repo/referral/referral_repo.dart';
import 'package:alwegdany/views/components/snackbar/show_custom_snackbar.dart';

class ReferralController extends GetxController {
  ReferralRepo referralRepo;
  ReferralController({required this.referralRepo});

  bool isLoading = true;
  List<ReferralData> referralList = [];

  String? nextPageUrl;
  int page = 0;
  String searchReferrals = "";

  TextEditingController searchController = TextEditingController();

  void initData() async {
    await allReferralsData();
    isLoading = false;
    update();
  }

  void loadPaginationData() async {
    await allReferralsData();
    update();
  }

  void searchReferral() async {
    filterLoading = true;
    update();
    page = 0;
    referralList.clear();
    searchReferrals = searchController.text;
    await allReferralsData();
    filterLoading = false;
    update();
  }

  Future<void> allReferralsData() async {
    page = page + 1;
    if (page == 1) {
      referralList.clear();
    }

    ResponseModel responseModel =
        await referralRepo.getReferralData(page, searchText: searchReferrals);

    if (responseModel.statusCode == 200) {
      ReferralModel referralModel =
          ReferralModel.fromJson(jsonDecode(responseModel.responseJson));

      nextPageUrl = referralModel.data?.referrals?.nextPageUrl;

      if (referralModel.status.toString().toLowerCase() == "success") {
        List<ReferralData>? tempList = referralModel.data?.referrals?.data;
        if (tempList != null && tempList.isNotEmpty) {
          referralList.addAll(tempList);
        }

        if (page == 1) {
          isLoading = false;
          update();
        }
      } else {
        MySnackbar.error(
            errorList:
                referralModel.message?.error ?? [MyStrings.somethingWentWrong]);
        return;
      }
    } else {
      MySnackbar.error(errorList: [responseModel.message]);
      return;
    }
  }

  bool isSearch = false;
  void changeSearchStatus() {
    isSearch = !isSearch;
    if (!isSearch) {
      searchController.text = '';
      filterData();
    }
    update();
  }

  bool filterLoading = false;
  Future<void> filterData() async {
    searchReferrals = searchController.text;
    page = 0;
    filterLoading = true;
    update();
    await allReferralsData();
    filterLoading = false;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null &&
            nextPageUrl!.isNotEmpty &&
            nextPageUrl != 'null'
        ? true
        : false;
  }
}
