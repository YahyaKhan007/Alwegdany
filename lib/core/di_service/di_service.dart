import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signal_lab/data/repo/auth/general_setting_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';

Future<void>init()async{

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(() => GeneralSettingRepo(apiClient: Get.find()), fenix: true);

}