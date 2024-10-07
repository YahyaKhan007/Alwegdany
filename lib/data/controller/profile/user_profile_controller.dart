
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/helper/shared_pref_helper.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/data/model/account/profile_response_model.dart';
import 'package:signal_lab/data/model/user/edit_profile/user_post_model.dart';
import 'package:signal_lab/data/repo/profile/user_profile_repo.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';

class UserProfileController extends GetxController{

  UserProfileRepo userProfileRepo;
  UserProfileController({required this.userProfileRepo}){
    loadProfileInfo();
  }
  ProfileResponseModel model=ProfileResponseModel();

  String imageStaticUrl='';

  String imageUrl='';

  bool isLoading = true;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController telegramController = TextEditingController();


  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode telegramFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();

  File? imageFile;




  loadProfileInfo() async {
    isLoading = true;
    update();
    model= await userProfileRepo.loadProfileInfo();
    if(model.data!=null && model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
      loadData(model);
    }else{
      isLoading=false;
      update();
    }

  }


  updateProfile()async{

    String firstName=firstNameController.text;
    String lastName=lastNameController.text.toString();
    String address=addressController.text.toString();
    String city=cityController.text.toString();
    String zip=zipCodeController.text.toString();
    String state=stateController.text.toString();
    String telegramUsername = telegramController.text.toString();
    User? user=model.data?.user;

    if(firstName.isNotEmpty && lastName.isNotEmpty){
      isLoading=true;
      update();

      UserPostModel model=UserPostModel(
          firstname: firstName, lastName: lastName, mobile: user?.mobile??'', email: user?.email??'',
          username: user?.username??'', countryCode: user?.countryCode??'', country: user?.address?.country??'', mobileCode: '880',
          image:imageFile, address: address, state: state,
          zip: zip, city: city,telegramUsername: telegramUsername);

      bool b= await userProfileRepo.updateProfile(model,true);

      if(b){
        await loadProfileInfo();
      }
      isLoading=false;
      update();
    }else{
      if(firstName.isEmpty){
        MySnackbar.error(errorList: [ MyStrings.kFirstNameNullError.tr]);
      } if(lastName.isEmpty){
        MySnackbar.error(errorList: [MyStrings.kLastNameNullError.tr]);
      }
    }

  }

  String countryName = '';
  String username = '';
  String telegramUsername = '';

  void loadData(ProfileResponseModel? model) {

    countryName = model?.data?.user?.address?.country??'';
    username = model?.data?.user?.username??'';
    telegramController.text = model?.data?.user?.telegramUsername??'';

    firstNameController.text=model?.data?.user?.firstname??'';
    userProfileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '${model?.data?.user?.username}');
    lastNameController.text = model?.data?.user?.lastname??'';
    emailController.text = model?.data?.user?.email??'';
    mobileNoController.text = model?.data?.user?.mobile??'';
    addressController.text =model?.data?.user?.address?.address??'';
    stateController.text = model?.data?.user?.address?.state??'';
    zipCodeController.text = model?.data?.user?.address?.zip??'';
    cityController.text = model?.data?.user?.address?.city??'';
    imageUrl=model?.data?.user?.image==null?'':'${model?.data?.user?.image}';

    isLoading=false;

    update();
  }
}