import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signal_lab/core/helper/date_converter.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/core/utils/util.dart';
import 'package:signal_lab/data/controller/referral/referral_controller.dart';
import 'package:signal_lab/data/repo/referral/referral_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/appbar/custom_appbar.dart';
import 'package:signal_lab/views/components/custom_loader.dart';
import 'package:signal_lab/views/components/no_data_found_screen.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<ReferralController>().hasNext()){
        Get.find<ReferralController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {

    MyUtil.makePortraitOnly();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ReferralRepo(apiClient: Get.find()));
    final controller = Get.put(ReferralController(referralRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page = 0;
      controller.initData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    MyUtil.makePortraitAndLandscape();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ReferralController>(
        builder: (controller) =>SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColor.backgroundColor,
        appBar: CustomAppBar(title: MyStrings.referrals,isShowActionBtn:true,icon:controller.isSearch ? Icons.clear : Icons.search,actionPress: (){
           controller.changeSearchStatus();
        },),
        body: controller.isLoading? const Center(
            child: CustomLoader()
          ) : Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: controller.isSearch,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    controller: controller.searchController,
                                    cursorColor: MyColor.primaryColor,
                                    style: interNormalSmall.copyWith(color: MyColor.colorWhite),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        hintText: MyStrings.searchByUsername,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                        hintStyle: interNormalSmall.copyWith(color: MyColor.hintTextColor),
                                        filled: true,
                                        fillColor: MyColor.backgroundColor,
                                        border: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5)),
                                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5)),
                                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5))
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: Dimensions.space10),

                          InkWell(
                            onTap: (){
                              controller.filterData();
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(4),
                                color: MyColor.primaryColor,
                              ),
                              child: const Icon(Icons.search_outlined, color:  MyColor.colorWhite, size: 18),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                Expanded(
                  child: controller.referralList.isEmpty && controller.filterLoading == false ? NoDataFoundScreen(bottomMargin: 10,title: MyStrings.noReferralFound,height: controller.isSearch?0.75:0.8,) : controller.filterLoading ? const Center(
                    child: CircularProgressIndicator(color: MyColor.primaryColor)
                  ) : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      shrinkWrap: true,
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.referralList.length + 1,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        if(controller.referralList.length == index){
                          return controller.hasNext() ? SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: CircularProgressIndicator(color: MyColor.primaryColor),
                            ),
                          ) : const SizedBox();
                        }
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                          decoration: BoxDecoration(
                              color: MyColor.cardBgColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                        "${index + 1}".padLeft(2,"0"),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(color: MyColor.textColor, fontWeight: FontWeight.w500, fontSize: 17),
                                      ),
                                    ),
                                    const SizedBox(width: Dimensions.space10),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                             Text(
                                              "${controller.referralList[index].firstname??''} ${controller.referralList[index].lastname??''}",
                                              style: interNormalDefault.copyWith(color: MyColor.colorWhite,),
                                              overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: Dimensions.space5),
                                          Text(
                                            controller.referralList[index].username ?? '',
                                            style: interNormalSmall.copyWith(color: Colors.white.withOpacity(.5), fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                             const SizedBox(width: Dimensions.space5,),
                             Text(
                                  DateConverter. isoStringToLocalDateOnly(controller.referralList[index].createdAt??''),
                                  style: interNormalSmall.copyWith(color: MyColor.colorGrey, fontWeight: FontWeight.w500),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
