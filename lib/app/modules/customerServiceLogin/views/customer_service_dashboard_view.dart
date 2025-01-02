import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:robua/app/data/colors.dart';
import 'package:robua/app/modules/contactUs/views/contact_us_view.dart';
import 'package:robua/app/modules/customerServiceLogin/controllers/customer_service_login_controller.dart';
import 'package:robua/app/modules/global/models/models.dart';
import 'package:robua/app/modules/home/views/home_view.dart';
import 'package:smooth_highlight/smooth_highlight.dart';

import '../../../data/constants.dart';
import '../../requests/views/details_view.dart';
import '../../requests/views/image_view.dart';

class CustomerServiceDashboardView
    extends GetView<CustomerServiceLoginController> {
  const CustomerServiceDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('لوحة التحكم',style: TextStyle(fontWeight: AppConstants.bold) ,),
            const Spacer(),
            IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Get.offAll(() => HomeView());
                }
            ),
SizedBox(width: 50,),

            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  AppConstants.userToken = null;
                  Get.offAll(() => HomeView());
                }
            ),

          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: CustomerList(),


    );
  }
}


class CustomerList extends StatelessWidget {

CustomerServiceLoginController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("مرحبا بك , الطلبات  (${controller.orders.length}) :",
                style: TextStyle(
                  fontSize: 20,
                ),

                ),
              ),
SizedBox(height: 10,),

              Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(

    children: [
      Text( 'العميل' , style: TextStyle(fontWeight: AppConstants.bold),),
      Spacer(flex: 4,),
      Text( 'رقم جوال العميل', style: TextStyle(fontWeight: AppConstants.bold),),
      Spacer(flex: 4,),
      Text( 'حالة الطلب', style: TextStyle(fontWeight: AppConstants.bold),),
      Spacer(),
      Text( 'التفاصيل', style: TextStyle(fontWeight: AppConstants.bold),),
    ],
  ),
),

      controller.isOrdersLoading.value ?
      Padding(
        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
        child: SpinKitRotatingPlain(
          size: 70,
          color: AppColors.secondaryColor,
        ),
      )
      :
      controller.isUpdatingOrderStatus.value ?
      Padding(
        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
        child: SpinKitRotatingPlain(
size: 70,
          color: AppColors.secondaryColor,
        ),
      )
          :
      ExpansionPanelList(

        expansionCallback: (int index, bool isExpanded) {
          controller.toggleExpansion(index);
        },
        children: controller.orders.map((order) {
          return ExpansionPanel(

            headerBuilder: (BuildContext context, bool isExpanded) {
              return SmoothHighlight(
                useInitialHighLight: true,

                color: Colors.yellow,
                duration: Duration(seconds: 2),
                enabled: order.id.toString() ==
                    controller.currentOrderId.value

                ,
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                          controller.names
                          [controller.orders.indexOf(order)]),
Spacer(),

                      Row(
                        children: [
                          Text( controller.phones[controller.orders.indexOf(order)]),
                          IconButton(onPressed: () async{
                            await  controller.launchPhone(controller.phones[controller.orders.indexOf(order)]);
                          }, icon:  Icon(Icons.phone , color: AppColors.secondaryColor,),)

                        ],
                      ),
                      // Spacer(flex: 4,),
                      //
                      // Spacer(flex: 4,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/6,
                        child: Text( order.status!,

                        ),
                      )
                      // SizedBox(
                      //
                      //   child: Text( order.status!,
                      //
                      //   ),
                      // ),

                    ],
                  ),


                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("السيرة الذاتية :" , style: TextStyle(fontWeight: AppConstants.bold),),

                      SizedBox(
                          height: 130,
                          width: 130,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => ImageView(order.cv!.image!));
                            },
                            child: CachedNetworkImage(
                                imageUrl: order.cv!.image!),
                          )

                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                      width: 300,
                      child: Divider(color: Colors.grey[300],  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('رقم جواز السفر: ' , style: TextStyle(fontWeight: AppConstants.bold),),
                      Text('${order.cv?.passportNo ?? ''}' ),
                    ],
                  ),
                  SizedBox(
                      width: 300,
                      child: Divider(color: Colors.grey[300],  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('الجنسية: ' , style: TextStyle(fontWeight: AppConstants.bold),),
                      Text('${order.cv?.nationality ?? ''}' ),
                    ],
                  ),
                  SizedBox(
                      width: 300,
                      child: Divider(color: Colors.grey[300],  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('الحالة: ' , style: TextStyle(fontWeight: AppConstants.bold),),
                      Text('${order.cv?.status ?? ''}' ),
                    ],
                  ),

                  SizedBox(
                      width: 300,
                      child: Divider(color: Colors.grey[300],  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('الوكيل: ' , style: TextStyle(fontWeight: AppConstants.bold),),
                      Text('${order.cv?.recruitmentOffice ?? ''}' ),
                    ],
                  ),
                  SizedBox(
                      width: 300,
                      child: Divider(color: Colors.grey[300],  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('النوع: ' , style: TextStyle(fontWeight: AppConstants.bold),),
                      Text('${order.cv?.cvType ?? ''}' ),
                    ],
                  ),
                  SizedBox(
                      width: 300,
                      child: Divider(color: Colors.grey[300],  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('التاريخ: ' , style: TextStyle(fontWeight: AppConstants.bold),),
                      Text('${order.order_date ?? ''}' ),
                    ],
                  ),
                  SizedBox(
                      width: 300,
                      child: Divider(color: Colors.grey[300],  )),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("التحكم :" , style: TextStyle(fontWeight: AppConstants.bold),),
                      controller.getOrderStatus(order.status!).isEmpty || controller.getOrderStatus(order.status!) == "ملغى" ? SizedBox() :    ElevatedButton(
                        onPressed: () async{
                          // Handle contract action
                          _showConfirmationDialog(false, order.id!);
                          // await controller.updateOrderStatus(order.id!, false);
                        },
                        child: Text('${controller.getOrderStatus(order.status!)}' ,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: AppConstants.bold
                          ),),

                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ) ,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async{
                          // Handle delete action
                          _showConfirmationDialog(true, order.id!);
                          // await controller.updateOrderStatus(order.id!, true);
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ) ,
                        ),
                        child: Icon(Icons.delete , color: Colors.white,),
                      ),
                      order.latitude != null && order.longitude != null ? ElevatedButton(
                        onPressed: () async{
                          // Handle delete action
                          await controller.openMap(double.tryParse(order.latitude!) ?? 0.0, double.tryParse(order.longitude!) ?? 0.0, );
                          // await controller.updateOrderStatus(order.id!, true);
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ) ,
                        ),
                        child: Icon(Icons.location_on , color: Colors.white,),
                      )
                          : SizedBox(),

                    ],
                  ),
                ],
              ),
            ),
            isExpanded: order.isExpanded,
          );
        }).toList(),
      )
            ],
          ),
        ],
      );
    });
  }
void _showConfirmationDialog(bool icCancel , id) {

 Get.dialog(
    AlertDialog(
      title: Text(icCancel ? 'الغاء الطلب' :'تعديل الطلب'),
      content: Text('هل انت متاكد من ${icCancel ? 'الغاء الطلب' :'تعديل الطلب'} ؟'),
      actions: [
        TextButton(
          onPressed: () async{
            // Handle Yes action
            Get.back();

            await controller.updateOrderStatus(id, icCancel);

            // Close the dialog
          },
          child: Text('نعم'),
        ),
        TextButton(
          onPressed: () {
            // Handle No action
            Get.back(); // Close the dialog
          },
          child: Text('لا'),
        ),
      ],
    ),
  )


 ;
}

}
