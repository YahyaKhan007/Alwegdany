import 'dart:io';

import 'package:alwegdany/core/route/route.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di_service/di_service.dart' as di_service;
import 'data/controller/translation_controller/translation_controller.dart';
import 'push_notification_service.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

SharedPreferences? prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationService().setupInteractedMessage();
  await di_service.init();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  prefs = await SharedPreferences.getInstance();
  if (prefs!.getString('Language_Code') == null) {
    prefs!.setString('Language_Code', 'ar');
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(prefs: prefs!));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      String langCode = prefs!.getString("Language_Code") ?? 'ar';
      Get.updateLocale(Locale(
        langCode,
      ));
      var firebaseController = Get.put(TranslationController());
      if (langCode == 'ar') {
        firebaseController.english.value = false;
      } else {
        firebaseController.english.value = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // textDirection: TextDirection.rtl,
      title: MyStrings.appName.tr,
      translations: MyStrings(),
      // locale: const Locale('ar'),
      locale: Locale(widget.prefs.getString('Language_Code')!),
      fallbackLocale: Locale(widget.prefs.getString('Language_Code')!),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      initialRoute: RouteHelper.splashScreen,
      transitionDuration: const Duration(milliseconds: 200),
      getPages: RouteHelper.routes,
      navigatorKey: Get.key,
      theme: ThemeData.dark(),
    );
  }
}
