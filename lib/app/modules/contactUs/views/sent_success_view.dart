import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';

import '../../../data/colors.dart';
import '../../../data/constants.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home_view.dart';

class SentSuccessView extends GetView {
  const SentSuccessView({super.key});
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
              Icon(Icons.check_circle, size: 200, color: Colors.green,).animate().fade(delay: 700.ms).slideX(delay: 400.ms),
              Text('لقد تم ارسال الطلب بنجاح',
                style: TextStyle(fontSize: 25, fontWeight: AppConstants.bold),),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(

                  "لقد استلمنا رسالتك و سنتواصل معك في أقرب وقت ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: AppConstants.semiBold),),
              ),




              SizedBox(height: 20,),
              MaterialButton(onPressed: () {
                Get.offAll(() => HomeView());

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
