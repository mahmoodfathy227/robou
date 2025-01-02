import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:robua/app/data/colors.dart';

import '../controllers/track_order_controller.dart';

class TrackOrderView extends GetView<TrackOrderController> {
  const TrackOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('تتبع طلبك'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: const Text(
              'أدخل رقم الطلب',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller.orderCodeController.value,
                decoration: InputDecoration(
                  hintText: 'أدخل هنا',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppColors.secondaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                )
              ),
              onPressed: () {
                // Get.toNamed(Routes.HOME);

                controller.getOrderStatus(controller.orderCodeController.value.text);

              },
              child: Text('تتبع طلبك' , style: TextStyle(color: Colors.white , fontSize: 17),),
            ),
          ),
          SizedBox(height: 50,),
          Center( child: Obx(() =>
          controller.orderStatus.value.isEmpty && !controller.isOrderStatusLoading.value ?
              SizedBox()
          :
          controller.isOrderStatusLoading.value ?
          SpinKitThreeInOut(color: AppColors.secondaryColor,) :
              Text(

                'حالة الطلب : ${controller.orderStatus.value}' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),),
          )
        ],
      )
    );
  }
}
