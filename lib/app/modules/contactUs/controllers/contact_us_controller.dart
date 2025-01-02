import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:dio/dio.dart' as dio;
import 'package:robua/app/modules/contactUs/views/sent_success_view.dart';
import '../../../../main.dart';
import '../../../data/colors.dart';
import '../../home/views/home_view.dart';

class ContactUsController extends GetxController {
  //TODO: Implement ContactUsController

  final count = 0.obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> subjectController = TextEditingController().obs;
  Rx<TextEditingController> messageController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  checkContactData() async{
    if(nameController.value.text.isEmpty || phoneController.value.text.isEmpty || subjectController.value.text.isEmpty || messageController.value.text.isEmpty){
Get.snackbar('خطأ', "من فضلك أكمل الحقول الإلزامية" ,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.secondaryColor,
    colorText: Colors.white,);
    }else{
      sendContactUsInfo();
    }
  }
  RxBool isSendingLoading = false.obs;

  sendContactUsInfo() async{
    if( !validatePhoneNumber(phoneController.value.text) ){
      return;
    }
    var data = {
      'name': nameController.value.text,
      'phone': phoneController.value.text,
      'subject': subjectController.value.text,
      'message': messageController.value.text
    };
    try{
      isSendingLoading.value = true;
      var response = await apiService.postMethod(
        endpoint:  '/home/get_in_touch',
          data: data);
      if (response.statusCode == 200) {
        print("success sending contact us ${json.encode(response.data)}");
        isSendingLoading.value = false;

        Get.off(()=> SentSuccessView());


      }
      else {
        print(response.statusMessage);
        print("failed sending contact us ${json.encode(response.data)}");
        isSendingLoading.value = false;


      }

    }
    catch(e){
      print("failed sending contact us ${json.encode(e.toString())}");
      isSendingLoading.value = false;
    }


  }

  bool validatePhoneNumber(String? value) {
    final RegExp regex = RegExp(r'^5\d{8}$');
    if (value == null || value.isEmpty) {
      Get.snackbar('خطأ', 'من فضلك أدخل رقم هاتف صالح');
      return false;
    } else if (!regex.hasMatch(value)) {
      Get.snackbar('خطأ', 'من فضلك أدخل رقم هاتف صالح');
      return false;
    }
    return true;
  }
}
