import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/data/controller/account/profile_complete/profile_complete_controller.dart';
import 'package:signal_lab/views/components/buttons/rounded_button.dart';
import 'package:signal_lab/views/components/buttons/rounded_loading_button.dart';
import 'package:signal_lab/views/components/text_field/custom_text_form_field.dart';

class ProfileCompleteForm extends StatefulWidget {

  const ProfileCompleteForm({Key? key,}) : super(key: key);

  @override
  State<ProfileCompleteForm> createState() => _ProfileCompleteFormState();
}

class _ProfileCompleteFormState extends State<ProfileCompleteForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileCompleteController>(
      builder: (controller) => Form(
        child: Column(
          children: [

            CustomTextFormField(
                labelText: MyStrings.firstName,
                onChanged: (value){
                  return;
                },
                focusNode: controller.firstNameFocusNode,
                controller: controller.firstNameController
            ),
            const SizedBox(height: 25),

            CustomTextFormField(
                labelText: MyStrings.lastName,
                onChanged: (value){
                  return;
                },
                focusNode: controller.lastNameFocusNode,
                controller: controller.lastNameController
            ),
            const SizedBox(height: 25),

            CustomTextFormField(
                labelText: MyStrings.address,
                onChanged: (value){
                  return;
                },
                focusNode: controller.addressFocusNode,
                controller: controller.addressController
            ),
            const SizedBox(height: 25),

            CustomTextFormField(
                labelText: MyStrings.state,
                onChanged: (value){
                  return ;
                },
                focusNode: controller.stateFocusNode,
                controller: controller.stateController
            ),
            const SizedBox(height: 25),

            CustomTextFormField(
                labelText: MyStrings.zipCode,
                onChanged: (value){
                  return;
                },
                focusNode: controller.zipCodeFocusNode,
                controller: controller.zipCodeController
            ),
            const SizedBox(height: 25),

            CustomTextFormField(
                labelText: MyStrings.city,
                onChanged: (value){
                  return ;
                },
                focusNode: controller.cityFocusNode,
                controller: controller.cityController,
            ),

            const SizedBox(height: 35),


            controller.submitLoading?
            const RoundedLoadingBtn() :
            RoundedButton(
                text: MyStrings.updateProfile,
                press: (){
                  controller.updateProfile();
                },
            )
          ],
        ),
      ),
    );
  }
}
