import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:robua/app/modules/contactUs/views/contact_us_view.dart';
import 'package:robua/app/modules/home/controllers/home_controller.dart';

import '../../../data/colors.dart';
import '../../../data/colors.dart';
import '../../../data/constants.dart';
import '../../global/widget/widgets.dart';
import '../controllers/requests_controller.dart';

class OrderView extends GetView<RequestsController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    //getting customer services data

    //if rent request location permisson
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('حجز الطلب'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller.nameValue.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  labelText: 'الإسم كاملا*',
                ),
              ),
            ),
            //phone
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: controller.phoneValue.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  labelText: 'رقم الهاتف*',
                ),
              ),
            ),


            Obx(() {
              return
                controller.type.value == 'rent' ?
Column(
  children: [
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Column(
            children: [
              Text("الموقع :", style: TextStyle(
                fontSize: 16,
                fontWeight: AppConstants.semiBold,)

                  ),
                  SizedBox(height: 10,),
                  Text("(يتطلب الوصول إلى اذن الموقع)", style: TextStyle(
                  fontSize: 8,
                  fontWeight: AppConstants.semiBold,)

                  ),
            ],
          ),
          SizedBox(width: 50,),
          Row(
            children: [
              MaterialButton(

                onPressed: () async{
                  if(controller.isGettingLocation.value == false){
                    await controller.getCurrentLocation();
                  } else {

                  }


              },

              child: controller.isGettingLocation.value ? CircularProgressIndicator(color: Colors.white,) :
              controller.lat.value.isEmpty ?
              Row(
                children: [
                  Text("تحديد موقعى", style: TextStyle(color: Colors.white),),
                  SizedBox(width: 10,),
                  Icon(Icons.check_circle, color: Colors.grey,)
                ],
              ) :
                  Icon(Icons.check_circle, color: Colors.white,),
              color: AppColors.secondaryColor,

              )
            ],
          )
        ],
      )
    ),
    SizedBox(height: 10,),
    Padding(
      padding: const EdgeInsets.all(16.0),
           child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text("مدة الإيجار :", style: TextStyle(
                    fontSize: 16,
                    fontWeight: AppConstants.semiBold,)

                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Obx(() {
                      return Column(
                        children: [
                          Text("من"),
                          SizedBox(height: 4,),
                          ElevatedButton(

                            onPressed: () async{
                              final DateTime? picked = await showDatePicker(
                                context: Get.context!,
                                initialDate: DateTime.now().add(Duration(days: 1)),
                                firstDate: DateTime.now().add(Duration(days: 1)),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null) {
                                controller.rentStartDate.value = "${picked.day}/${picked.month}/${picked.year}";
                              }
                            },
                            child: controller.rentStartDate.value.isEmpty ?
                            Text("اختيار التاريخ", style: TextStyle(color: Colors.white , fontSize: 8),) :
                            Text(controller.rentStartDate.value, style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Obx(() {
                      return Column(
                        children: [
                          Text("إلى"),
                          SizedBox(height: 4,),
                          ElevatedButton(

                            onPressed: () async{
                              final DateTime? picked = await showDatePicker(
                                context: Get.context!,
                                initialDate: DateTime.now().add(Duration(days: 1)),
                                firstDate: DateTime.now().add(Duration(days: 1)),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null) {
                                controller.rentEndDate.value = "${picked.day}/${picked.month}/${picked.year}";
                              }
                            },
                            child: controller.rentEndDate.value.isEmpty ?
                            Text("اختيار التاريخ", style: TextStyle(color: Colors.white, fontSize: 8),) :
                            Text(controller.rentEndDate.value, style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
    ),
  ],
)

                    :

                SizedBox();
            }),


            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "يرجى اختيار أحد ممثلي خدمة العملاء لمواصلة إتمام التعاقد وإكمال الإستقدام",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),

              ),
            ),
            _buildCustomerServices(context),
            SizedBox(height: 120,)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width / 1.6,
        child: Obx(() {
          return FloatingActionButton(
            heroTag: 'order',
            onPressed: () {
              // Handle button press
            },
            backgroundColor:

            controller.nameValue.value.text.isNotEmpty
                &&
                controller.phoneValue.value.text.isNotEmpty
                &&
                controller.selectedCustomerServiceId.value.isNotEmpty
                ?
            AppColors.secondaryColor
                :
            Colors.grey,


            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 2,
              child: Obx(() {
                return MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),

                  onPressed: () {
                    if(controller.type.value == 'rent'){
                      if(controller.rentStartDate.value.isEmpty ||
                          controller.rentEndDate.value.isEmpty ||
                          controller.rentStartDate.value.isEmpty ||
                          controller.rentEndDate.value.isEmpty ){
                        Get.snackbar("خطأ", "يرجى اكمال جميع الحقول");
                        return;
                      }
                    }
                    if (controller.nameValue.value.text.isNotEmpty &&
                        controller.phoneValue.value.text.isNotEmpty &&
                        controller.selectedCustomerServiceId.value.isNotEmpty
                    ) {
                      print("reserving.....");
                      controller.affirmOrder();
                    } else {
                      Get.snackbar("خطأ", "يرجى اكمال جميع الحقول");

                    }
                  },

                  child: controller.isAffirmingTheOrder.value ?
                  SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(color: Colors.white,)) :
                  Text('احجز الأن', style: TextStyle(
                    color:
                    Colors.white
                    ,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),


                );
              }),
            ),
          );
        }),
      ),
    );
  }

  _buildCustomerServices(context) {
    HomeController homeController = Get.find<HomeController>();
    return ShowUp(
      delay: 400,
      child: Column(
        children: [
          SizedBox(height: 30,),
          Text("خدمة العملاء والمبيعات", style: TextStyle(
              fontWeight: AppConstants.bold, color: Colors.black),),
          SizedBox(height: 10,),
          Text(" يمكنك التواصل مع طاقمنا المميز بكل سهولة ويسر ",
            style: TextStyle(
                fontWeight: FontWeight.w300, color: Colors.black),),
          SizedBox(height: 10,),
          Obx(() {
            return Container(
              height: 240,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    _buildCustomerRepresetativeCard(context: context,
                        name: homeController.customerServices.value.data[index]
                            .name,
                        whatsApp: homeController.customerServices.value
                            .data[index].whatsApp,
                        callNumber: homeController.customerServices.value
                            .data[index].phone,
                        index: index,


                        // modify this later
                        id: homeController.customerServices.value.data[index].id
                            .toString()

                    ),
                separatorBuilder: (context, index) => SizedBox(width: 20,),
                itemCount: homeController.customerServices.value.data.length,),
            ).animate().slideX(delay: 400.ms).fade(delay: 400.ms);
          }),
          SizedBox(height: 10,),

        ],
      ),
    );
  }

  _buildCustomerRepresetativeCard(
      {context, name, id, whatsApp, callNumber, index}) {
    HomeController homeController = Get.find<HomeController>();
    return GestureDetector(
      onTap: () {
        controller.setSelectedCustomerService(name, id, whatsApp, callNumber);
      },
      child: Obx(() {
        return Container(

            height: 220,
            width: MediaQuery
                .of(context)
                .size
                .width / 1.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: controller.selectedCustomerServiceName.value == name
                  ? AppColors.secondaryColor
                  : Color(0xffE4EAEE),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: homeController.customerServices.value
                          .data[index].image!,
                      fit: BoxFit.cover,
                      width: 80,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    name, style: TextStyle(fontWeight: FontWeight.w200, color:
                  controller.selectedCustomerServiceName.value == name ? Colors
                      .white :

                  Colors.black,
                      fontSize: 20
                  ),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          homeController.launchWhatsApp(whatsApp);
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          backgroundImage: CachedNetworkImageProvider(
                              "https://robuashaqraa.com/frontend/img/wh_icon.png"),
                          // child: CachedNetworkImage(imageUrl: "https://robuashaqraa.com/frontend/img/wh_icon.png", fit: BoxFit.cover,),

                        ),
                      ),
                      SizedBox(width: 30,),
                      GestureDetector(
                        onTap: () {
                          homeController.launchCall(callNumber);
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          backgroundImage: CachedNetworkImageProvider(
                              "https://robuashaqraa.com/frontend/img/call_icon.png"),

                          // child: CachedNetworkImage(imageUrl: "https://robuashaqraa.com/frontend/img/call_icon.png", fit: BoxFit.cover,),

                        ),
                      ),
                    ],
                  ),
                ]));
      }),
    );
  }
}
