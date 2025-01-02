import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:robua/app/data/colors.dart';
import 'package:robua/app/data/constants.dart';
import 'package:robua/app/modules/home/controllers/home_controller.dart';
import 'package:robua/app/modules/home/views/home_view.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'تواصل معنا', style: TextStyle(fontWeight: AppConstants.bold),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/about_us/earth.png",
                fit: BoxFit.cover,
              ).animate(autoPlay: true).rotate(
                  curve: Curves.easeInOut, delay: 400.ms).fade(),
              SizedBox(height: 30,),
              Container(
                width: 200,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.yellow,
                      width: 1.0,
                    )
                ),
                child: Center(child: Text("كن على اتصال", style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: AppConstants.semiBold,
                    fontSize: 25),).animate(autoPlay: true).fade()),
              ),
              SizedBox(height: 20,),
              _buildAddress(context),
              SizedBox(height: 20,),
              _buildSalesPhones(),
              SizedBox(height: 30,),
              _buildMainPhone(),
              SizedBox(height: 30,),
              _buildMainEmail(),
              SizedBox(height: 30,),
              _buildContactUsForm(),
            ],
          ),
        )
    );
  }

  HomeController homeController = Get.find<HomeController>();

  _buildAddress(context) {
    return Row(
      children: [
        SizedBox(width: 10,),
        CircleAvatar(
          radius: 30, // Adjust the radius as needed
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.location_on, color: Colors.blue, size: 30),
        ),

        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("عنوان مقرنا", style: TextStyle(
                color: Colors.black,
                fontWeight: AppConstants.semiBold,
                fontSize: 20),),
            Obx(() {
              return Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width -100,
                    child: Text(
                      homeController.settings.value.data!.address1!,
                      style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 13
                      ),),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    homeController.settings.value.data!.address2!,
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 13
                    ),),
                ],
              );
            })
          ],
        )
      ],
    );
  }

  _buildSalesPhones() {
    return Row(
      children: [
        SizedBox(width: 10,),
        CircleAvatar(
          radius: 30, // Adjust the radius as needed
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.phone, color: Colors.blue, size: 30),
        ),

        SizedBox(width: 10,),
        Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("المبيعات", style: TextStyle(
                  color: Colors.black,
                  fontWeight: AppConstants.semiBold,
                  fontSize: 20),),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () =>
                    homeController.launchCall(
                        homeController.settings.value.data!.phone1!),
                child: Text(
                  homeController.settings.value.data!.phone1!, style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 17
                ),),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () =>
                    homeController.launchCall(
                        homeController.settings.value.data!.phone2!),
                child: Text(
                  homeController.settings.value.data!.phone2!, style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 17
                ),),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () =>
                    homeController.launchCall(
                        homeController.settings.value.data!.phone3!),
                child: Text(
                  homeController.settings.value.data!.phone3!, style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 17
                ),),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () =>
                    homeController.launchCall(
                        homeController.settings.value.data!.phone4!),
                child: Text(
                  homeController.settings.value.data!.phone4!, style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 17
                ),),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () =>
                    homeController.launchCall(
                        homeController.settings.value.data!.phone5!),
                child: Text(
                  homeController.settings.value.data!.phone5!, style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 17
                ),),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () =>
                    homeController.launchCall(
                        homeController.settings.value.data!.phone6!),
                child: Text(
                  homeController.settings.value.data!.phone6!, style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 17
                ),),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () =>
                    homeController.launchCall(
                        homeController.settings.value.data!.phone7!),
                child: Text(
                  homeController.settings.value.data!.phone7!, style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 17
                ),),
              ),
            ],
          );
        })
      ],
    );
  }

  _buildMainPhone() {
    return Row(
      children: [
        SizedBox(width: 10,),
        CircleAvatar(
          radius: 30, // Adjust the radius as needed
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.phone_android, color: Colors.blue, size: 30),
        ),

        SizedBox(width: 10,),
        Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("الجوال الرئيسى", style: TextStyle(
                  color: Colors.black,
                  fontWeight: AppConstants.semiBold,
                  fontSize: 20),),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () =>
                    homeController.launchCall(
                        homeController.settings.value.data!.phone1!),
                child: Text(
                  homeController.settings.value.data!.phone1!, style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 17
                ),),
              ),

            ],
          );
        })
      ],
    );
  }

  _buildMainEmail() {
    return Row(
      children: [
        SizedBox(width: 10,),
        CircleAvatar(
          radius: 30, // Adjust the radius as needed
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.email, color: Colors.blue, size: 30),
        ),

        SizedBox(width: 10,),
        Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("البريد الإلكترونى", style: TextStyle(
                  color: Colors.black,
                  fontWeight: AppConstants.semiBold,
                  fontSize: 20),),
              SizedBox(height: 10,),
              Text(homeController.settings.value.data!.email!, style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 17
              ),),
              SizedBox(height: 10,),
              Text(
                homeController.settings.value.data!.email2!, style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 17
              ),),

            ],
          );
        })
      ],
    );
  }

  _buildContactUsForm() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("تواصل معنا", style: TextStyle(
              color: Colors.black,
              fontWeight: AppConstants.semiBold,
              fontSize: 20),),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              " فريق الدعم الفني معك على مدار الساعة لخدمتك وللإجابة عن الاسئلة و الإستفسارات",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: AppConstants.semiBold,
                  fontSize: 13),),
          ),
          Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Name
                      Text(
                        'الإسم كامل* ',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Add some space between the title and the TextField
                      TextField(
                        controller: controller.nameController.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),


                      SizedBox(height: 15.0),
                      //Phone
                      Text(
                        'رقم الهاتف* ',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Add some space between the title and the TextField
                      TextField(
                        controller: controller.phoneController.value,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),


                      SizedBox(height: 15.0),

                      //Subject
                      Text(
                        'الموضوع* ',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Add some space between the title and the TextField
                      TextField(
                        controller: controller.subjectController.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),


//Message
                      SizedBox(height: 15.0),
                      Text(
                        'الرسالة* ',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Add some space between the title and the TextField
                      TextField(
                        controller: controller.messageController.value,
                        maxLines: 8,
                        decoration: InputDecoration(
                          filled: true,

                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),


                      //Send Button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.checkContactData();
                          },
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor
                              ,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Obx(() {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: controller.isSendingLoading.value ?

                                Center(child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,)) :

                                Center(child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('ارسال', style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: AppConstants.semiBold,
                                        fontSize: 20),)
                                        .animate(autoPlay: true)
                                        .fade(),
                                    SizedBox(width: 10,),
                                    Icon(
                                      Icons.send, color: Colors.white,
                                      size: 20,)
                                  ],
                                )),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],))
          )
        ]);
  }
}
