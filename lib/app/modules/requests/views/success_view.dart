import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:robua/app/data/colors.dart';
import 'package:robua/app/modules/contactUs/views/contact_us_view.dart';

import '../../../data/constants.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home_view.dart';
import '../controllers/requests_controller.dart';

class SuccessView extends GetView<RequestsController> {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('تم ارسال الطلب بنجاح', style: TextStyle(fontWeight: AppConstants.semiBold),),
          centerTitle: true,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 200, color: Colors.green,).animate().fade(delay: 700.ms).
              slideX(delay: 400.ms).fade(delay: 400.ms),
              Text('لقد تم ارسال الطلب بنجاح',
                style: TextStyle(fontSize: 25, fontWeight: AppConstants.bold),),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(

                  "يمكنك متابعة طلبك عن طريق متابعة الطلب و ادخال رقم الطلب الخاص بكـ ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: AppConstants.semiBold),),
              ),
              Obx(() {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.orderTrackNo.value, style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),),
                    IconButton(onPressed: () async{

                      Get.snackbar('تم النسخ', 'تم نسخ رقم الطلب الخاص بك',
                          snackPosition: SnackPosition.BOTTOM);

                    }, icon: Icon(Icons.copy, color: Colors.blue,),)
                  ],);
              }),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  textAlign: TextAlign.center,
                  "أو يمكن التواصل مع ${controller.selectedCustomerServiceName} عن طريق الخيارات المتاحة",
                  style: TextStyle(fontSize: 18,
                      fontWeight: AppConstants.semiBold),),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {
                      controller.launchWhatsApp(controller.selectedCustomerServiceWhats);
                    },
                      icon: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: CachedNetworkImageProvider(
                            "https://robuashaqraa.com/frontend/img/wh_icon.png"),
                        // child: CachedNetworkImage(imageUrl: "https://robuashaqraa.com/frontend/img/wh_icon.png", fit: BoxFit.cover,),

                      ),
                    ),
                    SizedBox(width: 20,),
                    IconButton(onPressed: () {
                      controller.launchCall(controller.selectedCustomerServicePhone);
                    }, icon: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: CachedNetworkImageProvider(
                          "https://robuashaqraa.com/frontend/img/call_icon.png"),


                    ),),
                  ]),
              SizedBox(height: 20,),
              MaterialButton(onPressed: () {
Get.offAll(() => HomeView());
controller.clearAllOrderDetails();
Get.lazyPut(
      () => HomeController(),);
              },
                color: AppColors.secondaryColor,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: Text('الرئيسية',
                  style: TextStyle(fontWeight: AppConstants.semiBold,
                  color: Colors.white
                  ),),)
            ])


    );
  }
}
