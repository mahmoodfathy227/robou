import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class TrackOrderController extends GetxController {
  //TODO: Implement TrackOrderController

  final count = 0.obs;
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


  RxString orderStatus = ''.obs;
  RxBool isOrderStatusLoading = false.obs;
  Rx<TextEditingController> orderCodeController = TextEditingController().obs;
  getOrderStatus(String code) async{
try{
  isOrderStatusLoading.value = true;
  final response = await apiService.getRequest('/cvs/track/my/order?order_code=$code');
  if (response.statusCode == 200) {

    orderStatus.value = response.data['data']['order_status'];
    isOrderStatusLoading.value = false
    ;

  }
}catch(e){
  print("error getting order status $e");
  Get.snackbar("خطأ", 'تحقق من كود الطلب',snackPosition: SnackPosition.BOTTOM);
  isOrderStatusLoading.value = false;
}


  }
}
