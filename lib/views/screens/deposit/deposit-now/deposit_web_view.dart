import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/views/screens/deposit/deposit-now/widget/webview_widget.dart';

import '../../../components/appbar/custom_appbar.dart';

class DepositWebView extends StatefulWidget {

  final String redirectUrl;

  const DepositWebView({Key? key,
    required this.redirectUrl}) : super(key: key);


  @override
  State<DepositWebView> createState() => _DepositWebViewState();
}

class _DepositWebViewState extends State<DepositWebView> {
  @override
  void initState() {
    super.initState();
    permissionServices();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: const CustomAppBar(title: '',isShowBackBtn: true,bgColor: MyColor.primaryColor,),
      body: MyWebViewWidget(url: widget.redirectUrl),
      floatingActionButton: favoriteButton(),
    );
  }


  Widget favoriteButton() {
    return FloatingActionButton(
      backgroundColor: MyColor.redCancelTextColor,
      onPressed: () async {
        Get.back();
      },
      child: const Icon(Icons.cancel,color: MyColor.colorWhite,size: 30,),
    );
  }


  Future<Map<Permission, PermissionStatus>> permissionServices() async{

    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.microphone,
      Permission.mediaLibrary,
      Permission.camera,
      Permission.storage,
    ].request();

    return statuses;
  }

}