import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:robua/app/data/colors.dart';
import 'package:robua/app/data/constants.dart';
import 'package:robua/app/data/services/notification_service.dart';
import 'package:robua/app/modules/contactUs/controllers/contact_us_controller.dart';
import 'package:robua/app/modules/customerServiceLogin/controllers/customer_service_login_controller.dart';
import 'package:robua/app/modules/home/controllers/home_controller.dart';
import 'package:robua/app/modules/trackOrder/controllers/track_order_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/data/services/api_service.dart';
import 'app/data/utils/traslation.dart';
import 'app/modules/requests/controllers/requests_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await getUserToken();
await NotificationService.instance.initialize();

  await AppConstants.loadUserFromCache();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
     fontFamily: AppConstants.appFontFamily,
        scaffoldBackgroundColor: AppColors.primaryColor,
        appBarTheme: AppBarTheme( color: AppColors.primaryColor,),
      ),
      translations: Translation(),
      locale: AppConstants.userLang == null ? const Locale('ar') :
      AppConstants.userLang == 'ar'?
      const Locale('ar')
          :
      const Locale('en')
      ,
      fallbackLocale: const Locale('ar'),

      title: AppConstants.appName,
      initialRoute: AppPages.INITIAL,
      initialBinding:
        BindingsBuilder(() {
          Get.lazyPut(

                  () => HomeController(), fenix: true);
          Get.lazyPut(

              () => RequestsController(), fenix: true);
          Get.lazyPut(
          () => HomeController(),);
          Get.lazyPut(
                () => ContactUsController(), fenix: true);

          Get.lazyPut(
                  () => TrackOrderController(), fenix: true);
Get.put(CustomerServiceLoginController() , permanent: true);

          // Get.lazyPut(
          //         () => CustomerServiceLoginController(), fenix: true , );
      }),
      getPages: AppPages.routes,

    ),
  );
}

getUserToken() async{
  final prefs = await SharedPreferences.getInstance();
  AppConstants.userToken = prefs.getString('user_token');

}
final ApiService apiService = ApiService();

Future<String> getDeviceToken() async{
  final prefs = await SharedPreferences.getInstance();
  return  prefs.getString('user_token') ?? '';

}