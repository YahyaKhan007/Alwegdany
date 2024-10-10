import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/data/controller/profile/user_profile_controller.dart';
import 'package:alwegdany/views/components/buttons/rounded_button.dart';
import 'package:alwegdany/views/components/text_field/custom_text_form_field.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key? key}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      builder: (controller) {
        return Form(
          child: Column(
            children: [
              CustomTextFormField(
                labelText: MyStrings.firstName.tr,
                onChanged: (value) {
                  return;
                },
                focusNode: controller.firstNameFocusNode,
                controller: controller.firstNameController,
                nextFocus: controller.lastNameFocusNode,
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                labelText: MyStrings.lastName.tr,
                onChanged: (value) {
                  return;
                },
                focusNode: controller.lastNameFocusNode,
                controller: controller.lastNameController,
                nextFocus: controller.addressFocusNode,
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                labelText: MyStrings.address.tr,
                onChanged: (value) {
                  return;
                },
                focusNode: controller.addressFocusNode,
                controller: controller.addressController,
                nextFocus: controller.stateFocusNode,
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                labelText: MyStrings.state.tr,
                onChanged: (value) {
                  return;
                },
                focusNode: controller.stateFocusNode,
                controller: controller.stateController,
                nextFocus: controller.zipCodeFocusNode,
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                labelText: MyStrings.zipCode.tr,
                onChanged: (value) {
                  return;
                },
                focusNode: controller.zipCodeFocusNode,
                controller: controller.zipCodeController,
                nextFocus: controller.cityFocusNode,
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                labelText: MyStrings.city.tr,
                onChanged: (value) {
                  return;
                },
                focusNode: controller.cityFocusNode,
                controller: controller.cityController,
                nextFocus: controller.telegramFocusNode,
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                labelText: MyStrings.telegramUsername.tr,
                onChanged: (value) {
                  return;
                },
                focusNode: controller.telegramFocusNode,
                controller: controller.telegramController,
              ),
              const SizedBox(height: 40),
              RoundedButton(
                text: MyStrings.updateProfile.tr,
                press: () {
                  controller.updateProfile();
                },
                width: double.infinity,
              )
            ],
          ),
        );
      },
    );
  }
}
