import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/route/route.dart';
import 'package:alwegdany/data/model/account/profile_response_model.dart';
import 'package:alwegdany/data/model/user/edit_profile/user_post_model.dart';
import 'package:alwegdany/data/repo/auth/profile_complete/profile_complete_repo.dart';
import 'package:alwegdany/views/components/snackbar/show_custom_snackbar.dart';

class ProfileCompleteController extends GetxController {
  ProfileCompleteRepo profileRepo;

  ProfileResponseModel model = ProfileResponseModel();

  ProfileCompleteController({required this.profileRepo});

  bool isLoading = false;
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
  FocusNode countryFocusNode = FocusNode();
  FocusNode telegramFocusNode = FocusNode();

  bool submitLoading = false;
  updateProfile() async {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text.toString();
    String address = addressController.text.toString();
    String city = cityController.text.toString();
    String zip = zipCodeController.text.toString();
    String state = stateController.text.toString();
    String tgUsername = telegramController.text.toString();

    if (firstName.isEmpty) {
      MySnackbar.error(errorList: [MyStrings.kFirstNameNullError]);
      return;
    } else if (lastName.isEmpty) {
      MySnackbar.error(errorList: [MyStrings.kLastNameNullError]);
      return;
    }

    submitLoading = true;
    update();

    UserPostModel model = UserPostModel(
        image: null,
        firstname: firstName,
        lastName: lastName,
        mobile: '',
        email: '',
        username: '',
        countryCode: '',
        country: '',
        mobileCode: '8',
        address: address,
        state: state,
        zip: zip,
        city: city,
        telegramUsername: tgUsername);

    bool b = await profileRepo.updateProfile(model, false);

    if (b) {
      Get.offAllNamed(RouteHelper.homeScreen);
      return;
    }

    submitLoading = false;
    update();
  }
}
